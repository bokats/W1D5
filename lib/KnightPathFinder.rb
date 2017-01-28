require_relative '00_tree_node'

class KnightPathFinder
  BOARD_SIZE = 8
  DELTAS = [
    [-2, -1],
    [-2, 1],
    [-1, 2],
    [1, 2],
    [2, -1],
    [2, 1],
    [1, -2],
    [-1, -2]
  ]

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = []
  end

  def self.valid_moves(pos)
    valid_pos = []
    DELTAS.each do |shift|
      new_pos = [pos[0] + shift[0], pos[1] + shift[1]]
      if new_pos[0] >= 0 && new_pos[0] < BOARD_SIZE &&
         new_pos[1] >= 0 && new_pos[1] < BOARD_SIZE
        valid_pos << new_pos
      end
    end
    valid_pos
  end

  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos).select do |move|
      !@visited_positions.include?(move)
    end
  end

  def build_move_tree

    queue = [PolyTreeNode.new(@start_pos)]
    tree = []

    until queue.empty?
      current_node = queue.shift
      @visited_positions << current_node.value
      new_move_positions(current_node.value).each do |pos|
        child = PolyTreeNode.new(pos)
        child.parent = current_node
        tree << child
        queue << child
      end
    end
    tree
  end

  def find_path(end_pos)
    start = build_move_tree[0]
    p start
    trace_path_back(start.bfs(end_pos))
  end

  def trace_path_back(node)
    path = []
    queue = [node]

    until queue.empty?
      current_node = queue.shift
      path.unshift(current_node.value)
      queue << current_node.parent unless current_node.parent.nil?
    end
    path
  end
end
kpf = KnightPathFinder.new([0, 0])
# p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
