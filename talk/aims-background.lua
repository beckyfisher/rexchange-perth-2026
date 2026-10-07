-- Give every reveal.js slide the AIMS template content background unless the
-- slide sets its own background image.
--
-- Doing this in a filter rather than on each heading keeps the attribute off
-- twenty slide headings, where it would be repeated noise in the source and
-- easy to forget on a new slide. The image is extracted locally (or written as
-- a placeholder) by R/aims-assets.R.

local bg = "aims/content-background.jpg"

function Header(el)
  if not quarto.doc.is_format("revealjs") then return nil end
  if el.level ~= 2 or el.attributes["background-image"] ~= nil then
    return nil
  end
  el.attributes["background-image"] = bg
  el.attributes["background-size"] = "cover"
  return el
end
