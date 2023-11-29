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
    
    for i in 0...@grid_width do
      render_cube -1, i
      render_cube -1, i + @grid_width
    end
  end

  def render_grid
    for x in 0...@grid_width do
      for y in 0...@grid_height do
        render_cube(x, y) if @grid[x][y] != 0
      end
    end
  end

  # X and Y are positions on the grid, not pixels
  def render_cube(x, y)
    box_size = 30

    grid_x = (1280 - (@grid_width * box_size)) / 2
    grid_y = (720 - ((@grid_height - 2) * box_size)) / 2

    @args.outputs.solids << [grid_x + (x * box_size), (720 - grid_y) - (y * box_size), box_size, box_size, 255, 0, 0, 255]
  end

  def tick
    render
  end
end

def tick(args)
  args.state.game ||= TetrisGame.new(args)
  args.state.game.tick
end
