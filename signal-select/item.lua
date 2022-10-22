-- describe inventory item
local item = table.deepcopy(data.raw["item"]["constant-combinator"])
item.name = "list-combinator"
item.icons = {
  {
    icon = item.icon,
    tint = {r=1,g=0,b=0,a=0.3}
  },
}
item.place_result = "list-combinator"

-- describe inventory item recipe
local recipe = table.deepcopy(data.raw["recipe"]["constant-combinator"])
recipe.enabled = true
recipe.name = "list-combinator"
recipe.ingredients = {{"copper-plate",200},{"steel-plate",50}}
recipe.result = "list-combinator"

-- describe placed entity
local entity = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])
entity.name = "list-combinator"
entity.minable = {
  mining_time = 1,
  result = "list-combinator"
}

-- register each
data:extend{item,recipe,entity}
