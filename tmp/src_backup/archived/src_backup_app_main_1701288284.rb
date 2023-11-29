# frozen_string_literal: true

$gtk.reset

class TetrisGame
  RED = [255, 0, 0].freeze
  BLACK = [0, 0, 0].freeze
  WHITE = [255, 255, 255].freeze
  GREY = [20, 20, 20].freeze
  SCREEN_WIDTH = 1280
  SCREEN_HEIGHT = 720
  BOX_SIZE = 30
  SPEED = 1
  NEXT_MOVE = 30

  def initialize(args)
    @args = args
    @score = 0
    @game_over = false
    @grid_width = 10
    @grid_height = 20
    @current_piece_x = 5
    @current_piece_y = 0
    @next_move = NEXT_MOVE
    @grid = []
    @current_piece = [[1], [1, 1], [1]]

    @grid_width.times do |x|
      @grid[x] = []
      @grid_height.times do |y|
        @grid[x][y] = 0
      end
    end
  end

  def render
    render_background
    render_grid
    render_current_piece
    # render_score
  end

  def render_current_piece
    @current_piece.length.times do |x|
      @current_piece[x].length.times do |y|
        render_cube @current_piece_x + x, @current_piece_y + y, *RED
      end
    end
  end

  def render_background
    @args.outputs.solids << [0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, *BLACK]
    render_grid_border
  end

  def render_grid_border
    x = -1
    y = -1
    grid_border_width = @grid_width + 2
    grid_border_height = @grid_height + 2

    (x...(x + grid_border_width)).each do |i|
      render_cube i, y, *WHITE
      render_cube i, y + grid_border_height - 1, *WHITE
    end

    (y...(y + grid_border_height)).each do |i|
      render_cube x, i, *WHITE
      render_cube x + grid_border_width - 1, i, *WHITE
    end
  end

  # inner space
  def render_grid
    @grid_width.times do |x|
      @grid_height.times do |y|
        render_cube(x, y, *GREY) if @grid[x][y] != 0
      end
    end
  end

  # X and Y are positions on the grid, not pixels
  def render_cube(x, y, r, g, b, a = 255)
    grid_x = (SCREEN_WIDTH - (@grid_width * BOX_SIZE)) / 2
    grid_y = (SCREEN_HEIGHT - ((@grid_height - 2) * BOX_SIZE)) / 2

    @args.outputs.solids << [grid_x + (x * BOX_SIZE), (720 - grid_y) - (y * BOX_SIZE), BOX_SIZE, BOX_SIZE, r, g, b, a]
  end

  def iterate
    @next_move -= SPEED
    if @next_move <= 0
      @current_piece_y += 1
      @next_move = NEXT_MOVE
      if current_piece_colliding
        plant_current_piece
      end
    end
  end

  def plant_current_piece
    # make piece a part of the grid
    @current_piece.length.times do |x|
      @current_piece[x].length.times do |y|
        next if  @current_piece[x][y] == 0
          @grid[@current_piece_x + x][@current_piece_y + y] = @current_piece[x][y]
        end
      end
    end
    @current_piece_y = 0
  end

  def current_piece_colliding
    for x in 0...@current_piece.length do
      for y in 0...@current_piece[x].length do
        next if @current_piece[x][y] == 0

        if (@current_piece_y + y >= @grid_height - 1)
          return true
        elsif (@grid[@current_piece_x + x][@current_piece_y + y + 1] != 0)
          return true
        end
      end
    end

    false
  end

  def tick
    iterate
    render
  end
end

def tick(args)
  args.state.game ||= TetrisGame.new(args)
  args.state.game.tick
end
