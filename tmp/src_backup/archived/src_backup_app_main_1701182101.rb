# frozen_string_literal: true

def tick(args)
  init args
  render args
end

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

def render(args)
  render_background args
  # render_grid
  # render_score
end

def render_background(args)
  args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]
end

# X and Y are positions on the grid, not pixels
def render_cube(args, x, y)
  grid_x = 0
  grid_y = 0
  args.outputs.solids << [grid_x + , grid_y, 20, 20, 20]
end
