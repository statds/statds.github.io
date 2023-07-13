-- function Inline (el)
--   if el.t == "Cite" then
--     for k,_ in ipairs(el.content) do

--       if el.content[k].t == "Str" and el.content[k].text == "Godoy,"
--       and el.content[k+1].t == "Space"
--       and el.content[k+2].t == "Str" and el.content[k+2].text:find("^L. da C.") then

--           local _,e = el.content[k+2].text:find("^L. da C.")
--           local rest = el.content[k+2].text:sub(e+1) 
--           el.content[k] = pandoc.Underline { pandoc.Str("Godoy, L. da C.") }
--           el.content[k+1] = pandoc.Str(rest)
--           table.remove(el.content, k+2) 
--       end
--     end
--   end
--   return el
-- end

local hl_author = {
  Para = function(el)
    if el.t == "Para" then
    for k,_ in ipairs(el.content) do
      if el.content[k].t == "Str" and el.content[k].text == "Godoy,"
      and el.content[k+1].t == "Space"
      and el.content[k+2].t == "Str" and el.content[k+2].text:find("^L. da C.") then
          local _,e = el.content[k+2].text:find("^L. da C.")
          local rest = el.content[k+2].text:sub(e+1) 
          el.content[k] = pandoc.Underline { pandoc.Str("Godoy, L. da C.") }
          el.content[k+1] = pandoc.Str(rest)
          table.remove(el.content, k+2) 
      end
    end
  end
  return el
  end
}

function Div (div)
   if 'list' == div.identifier then
    return pandoc.walk_block(div, hl_author)
  end
  return nil
end
