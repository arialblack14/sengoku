defmodule Sengoku.Region do
  @enforce_keys [:value, :tile_ids]
  defstruct [:value, :tile_ids]

  def initialize_state(state) do
    Map.put(state, :regions, %{
      1 => %__MODULE__{value: 2, tile_ids: [1, 2, 3, 4]},
      2 => %__MODULE__{value: 2, tile_ids: [5, 6, 7]},
      3 => %__MODULE__{value: 5, tile_ids: [8, 9, 10, 11, 12, 13]},
      4 => %__MODULE__{value: 5, tile_ids: [14, 15, 16, 17, 18]},
      5 => %__MODULE__{value: 3, tile_ids: [19, 20, 21]},
      6 => %__MODULE__{value: 2, tile_ids: [22, 23, 24]}
    })
  end

  def containing_tile_ids(%{regions: regions}, tile_ids) do
    regions
    |> Map.values
    |> Enum.filter(fn(region) ->
         region.tile_ids -- tile_ids == []
       end)
  end
  def containing_tile_ids(_, _), do: []

  def stats do
    state =
      %{}
      |> initialize_state
      |> Sengoku.Tile.initialize_state

    Enum.map(state.regions, fn({id, region}) ->
      border_tile_count =
        Enum.count(region.tile_ids, fn(tile_id) ->
          neighbor_ids = state.tiles[tile_id].neighbors
          neighbor_ids -- region.tile_ids != []
        end)
      value_ratio = region.value / border_tile_count
      free_tiles = length(region.tile_ids) - border_tile_count

      {id, region.value, length(region.tile_ids), border_tile_count, free_tiles, value_ratio}
    end)
  end
end