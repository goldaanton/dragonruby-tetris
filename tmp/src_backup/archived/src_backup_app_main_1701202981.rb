# frozen_string_literal: true

$gtk.reset

class TetrisGame
  def initialize(args)
    @args = args
    @score = 0
    @game_over = false
    @grid_width = 10
    @grid_height = 20
    @current_piece_x = 5
    @current_piece_y = 0
    @grid = []

    for x in 0...@grid_width do
      @grid[x] = []
      for y in 0...@grid_height do
        @grid[x][y] = 0
      end
    end
  end

  def render
    render_background
    render_grid
    # render_score
  end

  def render_background
    @args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]
    render_grid_border
  end

  def render_grid_border
    x = -1
    y = -1
    grid_border_width = @grid_width + 2
    grid_border_height = @grid_height + 2

    color = [255, 255, 255]

    for i in x...(x + grid_border_width) do
      render_cube i, y, *color
      render_cube i, y + grid_border_height - 1, *color
    end

    for i in y...(y + grid_border_height) do
      render_cube x, i, *color
      render_cube x + grid_border_width - 1, i, *color
    end
  end

  def render_grid
    for x in 0...@grid_width do
      for y in 0...@grid_height do
        render_cube(x, y, 0, 255, 0) if @grid[x][y] != 0
      end
    end
  end

  # X and Y are positions on the grid, not pixels
  def render_cube(x, y, r, g, b, a = 255)
    box_size = 30

    grid_x = (1280 - (@grid_width * box_size)) / 2
    grid_y = (720 - ((@grid_height - 2) * box_size)) / 2

    @args.outputs.solids << [grid_x + (x * box_size), (720 - grid_y) - (y * box_size), box_size, box_size, r, g, b, a]
  end

  def tick
    render
    @grid[0][4] = 1
    @grid[1][4] = 1
    @grid[2][4] = 1
    @grid[1][5] = 1
    @grid[1][6] = 1

    @grid[4][4] = 1
    @grid[4][5] = 1
    @grid[4][6] = 1
    @grid[5][6] = 1
    @grid[6][6] = 1
    @grid[6][5] = 1
    @grid[6][4] = 1
    @grid[6][3] = 1
  end
end

def tick(args)
  args.state.game ||= TetrisGame.new(args)
  args.state.game.tick
end
