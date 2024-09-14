function change(amount)
  if math.type(amount) ~= "integer" then
    error("Amount must be an integer")
  end
  if amount < 0 then
    error("Amount cannot be negative")
  end
  local counts, remaining = {}, amount
  for _, denomination in ipairs({25, 10, 5, 1}) do
    counts[denomination] = remaining // denomination
    remaining = remaining % denomination
  end
  return counts
end

-- Write your first then lower case function here
function first_then_lower_case(a, b)
  for _, value in ipairs(a) do
    if b(value) then
        return string.lower(value)
    end
  end
  return nil
end

-- Write your powers generator here
function powers_generator(base, limit)
  value = 1
  return coroutine.create(function ()
    while value <= limit do
      coroutine.yield(value)
      value = base * value
    end
  end)
end

-- Write your say function here
function say(word, words)
  words = words or {}
  if word ~= nil then
    table.insert(words,word)
    return function (a) 
      return say(a, words);
    end
  else
    return table.concat(words, " ")
  end
end

-- Write your line count function here
function meaningful_line_count(file_name)
  local file, err = io.open(file_name, "r")
  if not file then
      error(err)
  end
  local valid_line_count = 0
  for line in file:lines() do
      local stripped_line = line:match("^%s*(.-)%s*$")  -- Remove leading and trailing whitespace
      if stripped_line ~= "" and not stripped_line:find("^#") then
          valid_line_count = valid_line_count + 1
      end
  end

  file:close()
  return valid_line_count
end

-- Write your Quaternion table here

