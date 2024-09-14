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
  local value = 1
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

Quaternion = {}
Quaternion.__index = Quaternion

function Quaternion.new(a, b, c, d)
  local self = setmetatable({}, Quaternion)
  self.a = a or 0
  self.b = b or 0
  self.c = c or 0
  self.d = d or 0
  return self
end

function Quaternion:conjugate()
  return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end

function Quaternion:coefficients()
  return {self.a, self.b, self.c, self.d}
end

function Quaternion.__mul(self, other)
  local a = self.a * other.a - self.b * other.b - self.c * other.c - self.d * other.d
  local b = self.a * other.b + self.b * other.a + self.c * other.d - self.d * other.c
  local c = self.a * other.c - self.b * other.d + self.c * other.a + self.d * other.b
  local d = self.a * other.d + self.b * other.c - self.c * other.b + self.d * other.a
  return Quaternion.new(a, b, c, d)
end

function Quaternion.__add(self, other)
  return Quaternion.new(self.a + other.a, self.b + other.b, self.c + other.c, self.d + other.d)
end

function Quaternion.__eq(self, other)
  return self.a == other.a and self.b == other.b and self.c == other.c and self.d == other.d
end

function Quaternion:__tostring()
  local function format_component(value, component)
    local sign, abs_val
    if value == 0 then
        return ""
    end

    if value > 0 then
        sign = "+"
    else
        sign = "-"
    end

    abs_val = math.abs(value)

    if component == 'w' then
        return tostring(value)
    elseif abs_val == 1 then
        return sign .. component
    else
        return sign .. tostring(abs_val) .. component
    end
end
local components = {  
    format_component(self.a, 'w'),
    format_component(self.b, 'i'),
    format_component(self.c, 'j'),
    format_component(self.d, 'k')
}
local str = table.concat(components, ""):gsub("%+%-", "-")
if str:sub(1, 1) == "+" then
    str = str:sub(2)
elseif str == "" then
    str = "0"
end

return str
end

