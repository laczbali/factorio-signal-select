-- describe placed entity
local entity = flib.copy_prototype(data.raw["constant-combinator"]["constant-combinator"], "list-combinator")

-- describe inventory item
local item = flib.copy_prototype(data.raw["item"]["constant-combinator"], "list-combinator")
item.icons = {
  {
    icon = item.icon,
    tint = {r=1,g=0,b=0,a=0.3}
  },
}

-- describe inventory item recipe
local recipe = flib.copy_prototype(data.raw["recipe"]["constant-combinator"], "list-combinator")
recipe.ingredients = {{"copper-plate",200},{"steel-plate",50}}

-- register each
data:extend({
  entity,
  item,
  recipe
})
