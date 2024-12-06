package main

import (
	"log"
	"math/rand"
	"sync"
	"sync/atomic"
	"time"
)

func do(seconds int, action ...any) {
	log.Println(action...)
	randomMillis := 500*seconds + rand.Intn(500*seconds)
	time.Sleep(time.Duration(randomMillis) * time.Millisecond)
}

type Order struct {
	customer   string
	id         uint64
	reply      chan *Order
	preparedBy string
}

var nextId atomic.Uint64
var waiter = make(chan *Order, 3)

func cook(name string) {
	log.Println(name, "starting work")
	for order := range waiter {
		do(10, name, "is cooking", order.id)
		order.preparedBy = name
		order.reply <- order
	}
}

func customer(name string, waitGroup *sync.WaitGroup) {
	defer waitGroup.Done()
	for mealsEaten := 0; mealsEaten < 5; {
		order := &Order{id: nextId.Add(1), customer: name, reply: make(chan *Order, 1)}
		log.Println(name, "placed order", order.id)
		select {
		case waiter <- order:
			meal := <-order.reply
			do(2, name, "eating cooked order", meal.id, "prepared by", meal.preparedBy)
			mealsEaten++
		case <-time.After(7 * time.Second):
			do(5, name, "waiting too long, abandoning order", order.id)
		}
	}
	log.Println(name, "going home")
}

func main() {
	customers := [10]string{"Ani", "Bai", "Cat", "Dao", "Eve", "Fay", "Gus", "Hua", "Iza", "Jai"}
	go cook("Remy")
	go cook("Collete")
	go cook("Linguini")
	var waitGroup sync.WaitGroup
	for _, name := range customers {
		waitGroup.Add(1)
		go customer(name, &waitGroup)
	}
	waitGroup.Wait()
	log.Println("Restaurant closing")
}
