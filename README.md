# README Demo API

## Problems
- If-else duplication
- Updating/Destroying resources in a controller for several specific conditions. Well it works in that controller, what if someone performs updating/destroying in rails console.

## What for now
- Centralize exception handling with ApiResponder
- Move business validation to modal using rails/custom validators
- We don't use `find_by`, `save`, `update_attributes`, `update`, `destroy`, `create`
- But use `find_by!`, `save!`, `update_attributes!`, `update!`, `destroy!`, `create!`

## What can be extended with this approach?
- Easily do translation.
- Easily standardize returning result (Format, deprecated info, meta data)
- Easily standardize http code / error code
