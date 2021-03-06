defmodule Sengoku.AI.Random do
  @moduledoc """
  An AI that chooses moves more-or-less randomly.
  A baseline against which to test other AIs.
  """

  @behaviour Sengoku.AI

  alias Sengoku.{Game, Tile}

  def take_action(state) do
    cond do
      has_unplaced_units?(state) -> place_unit(state)
      has_required_move?(state) -> make_required_move(state)
      has_attackable_neighbor?(state) -> attack(state)
      can_move?(state) -> move(state)
      true -> end_turn()
    end
  end

  defp has_unplaced_units?(state) do
    Game.current_player(state).unplaced_units > 0
  end

  defp place_unit(state) do
    tile_id =
      state
      |> owned_tile_ids
      |> Enum.random()

    %{type: "place_unit", tile_id: tile_id}
  end

  defp has_required_move?(state) do
    not is_nil(state.required_move)
  end

  defp make_required_move(%{required_move: required_move}) do
    %{
      type: "move",
      from_id: required_move.from_id,
      to_id: required_move.to_id,
      count: Enum.random(required_move.min..required_move.max)
    }
  end

  defp has_attackable_neighbor?(state) do
    state
    |> tile_ids_with_attackable_neighbors
    |> length > 0
  end

  defp attack(state) do
    tile_with_attackable_neighbor_id =
      state
      |> tile_ids_with_attackable_neighbors
      |> Enum.random()

    attackable_neighbor_id =
      tile_with_attackable_neighbor_id
      |> find_attackable_neighbor_id(state)

    %{
      type: "attack",
      from_id: tile_with_attackable_neighbor_id,
      to_id: attackable_neighbor_id
    }
  end

  defp tile_ids_with_attackable_neighbors(state) do
    state
    |> Tile.filter_ids(fn tile ->
      tile.owner == state.current_player_id && tile.units > 1 &&
        tile.neighbors
        |> Enum.any?(fn neighbor_id ->
          neighbor = state.tiles[neighbor_id]
          neighbor.owner !== state.current_player_id
        end)
    end)
  end

  defp find_attackable_neighbor_id(tile_id, state) do
    state.tiles[tile_id].neighbors
    |> Enum.filter(fn neighbor_id ->
      neighbor = state.tiles[neighbor_id]
      neighbor.owner !== state.current_player_id
    end)
    |> Enum.random()
  end

  defp owned_tile_ids(state) do
    state
    |> Tile.filter_ids(fn tile ->
      tile.owner == state.current_player_id
    end)
  end

  defp end_turn do
    %{type: "end_turn"}
  end

  def can_move?(state) do
    state
    |> tile_ids_with_friendly_neighbors
    |> length > 0
  end

  def move(state) do
    tile_with_friendly_neighbor_id =
      state
      |> tile_ids_with_friendly_neighbors
      |> Enum.random()

    tile_with_friendly_neighbor_units = state.tiles[tile_with_friendly_neighbor_id].units

    friendly_neighbor_id =
      tile_with_friendly_neighbor_id
      |> find_friendly_neighbor_id(state)

    %{
      type: "move",
      from_id: tile_with_friendly_neighbor_id,
      to_id: friendly_neighbor_id,
      count: tile_with_friendly_neighbor_units
    }
  end

  defp tile_ids_with_friendly_neighbors(state) do
    state
    |> Tile.filter_ids(fn tile ->
      tile.owner == state.current_player_id && tile.units > 0 &&
        tile.neighbors
        |> Enum.any?(fn neighbor_id ->
          neighbor = state.tiles[neighbor_id]
          neighbor.owner == state.current_player_id
        end)
    end)
  end

  defp find_friendly_neighbor_id(tile_id, state) do
    state.tiles[tile_id].neighbors
    |> Enum.filter(fn neighbor_id ->
      neighbor = state.tiles[neighbor_id]
      neighbor.owner == state.current_player_id
    end)
    |> Enum.random()
  end
end
