# frozen_string_literal: true

class TetrisGame

  def init(args)
    args.state.score ||= 0
    args.state.game_over ||= false
    args.state.grid_width ||= 10
    args.state.grid_height ||= 20
    args.state.current_piece_x ||= 5
    args.state.current_piece_y ||= 0

    if args.state.grid.nil?
      args.state.grid = []
      for x in 0...args.state.grid_width do
        args.state.grid[x] = []
        for y in 0...args.state.grid_height do
          args.state.grid[x][y] = 0
        end
      end
    end
  end

  def tick(args)
    init args
    render args
  end

  def render(args)
    render_background args
    render_grid args
    # render_score
  end

  def render_background(args)
    args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]
  end

  def render_grid(args)
    for x in 0...args.state.grid_width do
      for y in 0...args.state.grid_height do
        render_cube(args, x, y)
      end
    end
  end

  # X and Y are positions on the grid, not pixels
  def render_cube(args, x, y)
    box_size = 30

    grid_x = (1280 - (args.state.grid_width * box_size)) / 2
    grid_y = (720 - ((args.state.grid_height - 2) * box_size)) / 2

    args.outputs.solids << [grid_x + (x * box_size), (720 - grid_y) - (y * box_size), box_size, box_size, 255, 0, 0, 255]
  end
end
