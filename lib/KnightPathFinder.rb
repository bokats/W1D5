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
    visited_pos = []
    queue = [pos]

    until queue.empty?
      current_pos = queue.shift
      visited_pos << current_pos
      DELTAS.each do |shift|
        new_pos = current_pos[0] + shift[0], current_pos[1] + shift[1]
        if new_pos[0] >= 0 && new_pos[0] < BOARD_SIZE &&
           new_pos[1] >= 0 && new_pos[1] < BOARD_SIZE
          queue << new_pos
        end
      end
    end
    visited_pos
  end

  def new_move_positions(pos)
    KnightPathFinder.valid_moves?(pos).select do |move|
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
    start = tree[0]
    trace_path_back(start.bfs(end_pos))
  end

  def trace_path_back(node)
    path = []
    queue = [node]

    until queue.empty?
      current_node = queue.shift
      path.unshift(current_node.value)
      queue << current_node.parent unless curren_node.parent.nil?
    end
    path
  end
end
