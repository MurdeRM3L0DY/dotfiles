-- function hsl2rgb(h,s,l)
-- {
--    let a=s*Math.min(l,1-l);
--    let f= (n,k=(n+h/30)%12) => l - a*Math.max(Math.min(k-3,9-k,1),-1);
--    return [f(0),f(8),f(4)];
-- }

local hsl2rgb = function(h, s, l)
  local f = function(n)
    local a = s * math.min(l, 1 - l)
    local k = (n + h / 30) % 12

    return l - a * math.max(math.min(k - 3, 9 - k, 1), -1)
  end

  return math.floor(255 * f(0)), math.floor(255 * f(8)), math.floor(255 * f(4))
end

local r, g, b = hsl2rgb(50, 200, 45)
print(r, g, b)
