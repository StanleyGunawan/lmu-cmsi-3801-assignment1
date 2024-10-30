public class test {

    enum Color {
        RED, YELLOW, GREEN
    }

    public static void main(String[] args) {
        Color color = Color.RED;
        System.out.println(switch (color) {
            case Color.RED -> "stop";
            case Color.YELLOW -> "slow down";
            case Color.GREEN -> "go";
          });
    }
}
