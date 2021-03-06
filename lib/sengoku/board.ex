defmodule Sengoku.Board do
  @moduledoc """
  Holds any and all board-specific data on the server.
  """

  defstruct [:players_count, :regions, :tiles, :name]

  alias Sengoku.{Region, Tile}

  @doc """
  Returns a Board struct with the data specific to a given board.
  """
  def new("japan") do
    %__MODULE__{
      name: "japan",
      players_count: 4,
      regions: %{
        1 => %Region{value: 2, tile_ids: [1, 2, 3, 4]},
        2 => %Region{value: 2, tile_ids: [5, 6, 7]},
        3 => %Region{value: 5, tile_ids: [8, 9, 10, 11, 12, 13]},
        4 => %Region{value: 5, tile_ids: [14, 15, 16, 17, 18]},
        5 => %Region{value: 3, tile_ids: [19, 20, 21]},
        6 => %Region{value: 2, tile_ids: [22, 23, 24]}
      },
      tiles: %{
        1 => Tile.new([2]),
        2 => Tile.new([1, 3, 4, 5]),
        3 => Tile.new([2, 4]),
        4 => Tile.new([2, 3, 5, 8]),
        5 => Tile.new([2, 4, 6, 7, 8]),
        6 => Tile.new([5, 7]),
        7 => Tile.new([5, 6, 8, 10, 11]),
        8 => Tile.new([4, 5, 7, 9, 10]),
        9 => Tile.new([8, 10]),
        10 => Tile.new([7, 8, 9, 12, 13]),
        11 => Tile.new([7, 12]),
        12 => Tile.new([10, 11, 13, 14, 15, 16]),
        13 => Tile.new([10, 12, 14]),
        14 => Tile.new([12, 13, 16, 17]),
        15 => Tile.new([12, 16]),
        16 => Tile.new([12, 14, 15, 17, 18]),
        17 => Tile.new([14, 16, 18, 20, 21, 23]),
        18 => Tile.new([16, 17, 19, 20]),
        19 => Tile.new([18, 20]),
        20 => Tile.new([17, 18, 19, 21, 22]),
        21 => Tile.new([17, 20, 22, 23]),
        22 => Tile.new([20, 21, 23]),
        23 => Tile.new([17, 21, 22, 24]),
        24 => Tile.new([23])
      }
    }
  end

  def new("earth") do
    %__MODULE__{
      name: "earth",
      players_count: 6,
      regions: %{
        # North America
        1 => %Region{value: 5, tile_ids: Enum.to_list(1..9)},
        # South America
        2 => %Region{value: 2, tile_ids: Enum.to_list(10..13)},
        # Africa
        3 => %Region{value: 3, tile_ids: Enum.to_list(14..19)},
        # Europe
        4 => %Region{value: 5, tile_ids: Enum.to_list(20..26)},
        # Asia
        5 => %Region{value: 7, tile_ids: Enum.to_list(27..38)},
        # Australia America
        6 => %Region{value: 2, tile_ids: Enum.to_list(39..42)}
      },
      tiles: %{
        1 => Tile.new([2, 4, 30]),
        2 => Tile.new([1, 3, 4, 5]),
        3 => Tile.new([2, 5, 6, 24]),
        4 => Tile.new([1, 2, 5, 7]),
        5 => Tile.new([2, 3, 4, 6, 7, 8]),
        6 => Tile.new([3, 5, 8]),
        7 => Tile.new([4, 5, 8, 9]),
        8 => Tile.new([5, 6, 7, 9]),
        9 => Tile.new([7, 8, 10]),
        10 => Tile.new([9, 11, 12]),
        11 => Tile.new([10, 12, 13]),
        12 => Tile.new([10, 11, 13, 18]),
        13 => Tile.new([11, 12]),
        14 => Tile.new([15, 16, 17]),
        15 => Tile.new([14, 17]),
        16 => Tile.new([14, 17, 18]),
        17 => Tile.new([14, 15, 16, 18, 19, 36]),
        18 => Tile.new([12, 16, 17, 19, 20, 21]),
        19 => Tile.new([17, 18, 21, 36]),
        20 => Tile.new([18, 21, 22, 23]),
        21 => Tile.new([18, 19, 20, 23, 26, 36]),
        22 => Tile.new([20, 23, 24, 25]),
        23 => Tile.new([20, 21, 22, 25, 26]),
        24 => Tile.new([3, 22, 25]),
        25 => Tile.new([22, 23, 24, 26]),
        26 => Tile.new([21, 23, 25, 27, 34, 36]),
        27 => Tile.new([26, 28, 34, 35]),
        28 => Tile.new([27, 29, 31, 32, 35]),
        29 => Tile.new([28, 30, 31]),
        30 => Tile.new([1, 29, 31, 32, 33]),
        31 => Tile.new([28, 29, 30, 32]),
        32 => Tile.new([28, 30, 31, 33, 35]),
        33 => Tile.new([30, 32]),
        34 => Tile.new([26, 27, 35, 36, 37]),
        35 => Tile.new([27, 28, 32, 33, 34, 37, 38]),
        36 => Tile.new([17, 19, 21, 26, 34, 37]),
        37 => Tile.new([34, 35, 36, 38]),
        38 => Tile.new([35, 37, 39]),
        39 => Tile.new([38, 40, 41]),
        40 => Tile.new([39, 41, 42]),
        41 => Tile.new([39, 42]),
        42 => Tile.new([40, 41])
      }
    }
  end
end
