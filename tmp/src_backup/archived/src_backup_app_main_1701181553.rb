# frozen_string_literal: true

def tick(args)
  init args
  args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]
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
      for y in 0...args.state.grid_height do
    end
  end
end
