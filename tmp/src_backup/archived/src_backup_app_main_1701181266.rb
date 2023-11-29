# frozen_string_literal: true

def tick(args)
  init args
end

def init(args)
  args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]
end
