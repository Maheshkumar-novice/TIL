class Node:
    def __init__(self, key=0, value=0):
        self.key = key
        self.value = value
        self.prev = None
        self.next = None

class LRUCache:
    def __init__(self, capacity: int):
        self.capacity = capacity
        self.cache = {}  # Hash map: key -> Node

        # Dummy head and tail to avoid edge cases
        self.head = Node()
        self.tail = Node()
        self.head.next = self.tail
        self.tail.prev = self.head

    # --- Linked List Helper Functions ---
    def _add_node(self, node):
        """Always add the new node right after the dummy head (Most Recent)."""
        node.prev = self.head
        node.next = self.head.next
        
        self.head.next.prev = node
        self.head.next = node

    def _remove_node(self, node):
        """Remove an existing node from the linked list."""
        prev_node = node.prev
        next_node = node.next
        
        prev_node.next = next_node
        next_node.prev = prev_node

    def _move_to_head(self, node):
        """Move a node to the head when it is accessed."""
        self._remove_node(node)
        self._add_node(node)

    def _pop_tail(self):
        """Pop the actual tail node (the one right before the dummy tail)."""
        res = self.tail.prev
        self._remove_node(res)
        return res

    # --- Core Cache Operations ---
    def get(self, key: int) -> int:
        node = self.cache.get(key)
        if not node:
            return -1
        
        # If accessed, it becomes the most recently used
        self._move_to_head(node)
        return node.value

    def put(self, key: int, value: int) -> None:
        node = self.cache.get(key)

        if node:
            # Update the value and move to front
            node.value = value
            self._move_to_head(node)
        else:
            # Create a new node
            new_node = Node(key, value)
            self.cache[key] = new_node
            self._add_node(new_node)
            
            # Check if we exceeded capacity
            if len(self.cache) > self.capacity:
                # Evict the least recently used (tail)
                tail = self._pop_tail()
                del self.cache[tail.key]
