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
  args.state.current_pice
end
