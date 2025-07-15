# Snake Game AI Agent Project

A Python-based Snake Game implementation using Pygame, optimized for AI agent integration and performance evaluation.

## Project Overview

This project consists of a classic Snake Game where the goal is to develop an intelligent agent that can play the game autonomously and achieve high scores in minimal time.

## Game Components

- **Snake**: Controlled by keyboard arrows or by the AI agent
- **Apple**: Food that appears at predefined positions when eaten
- **Game Environment**: 1000x800 pixel window with walls (boundaries)

## Game Mechanics

- Snake starts with length 1 and increases by 1 each time it eats an apple
- Game ends when snake collides with itself or the walls
- Score equals the number of apples eaten (snake length - 1)
- Game speed increases every 5 apples eaten
- Performance metrics track both score and time

## Files Structure

- `source.py`: Main game implementation with agent integration hooks
- `index.py`: Entry point for the game with the same implementation
- `resources/`: Directory containing game assets (images, sounds)

## Running the Game

```bash
python source.py  # Run the game with default settings
```

## Building an AI Agent

The game provides hooks for implementing various AI agents. Two sample agents are included:

1. `random_agent()`: Makes random moves (baseline)
2. `agent_bikram()`: Simple greedy agent that moves directly toward the apple

### Creating Your Own Agent

To implement your own AI agent, modify the `agent_P()` method in the `Game` class:

```python
def agent_P(self):
    """
    Your AI agent implementation goes here.
    Available information:
    - Snake head position: self.snake.x[0], self.snake.y[0]
    - Snake body segments: self.snake.x[1:], self.snake.y[1:]
    - Apple position: self.apple.x, self.apple.y
    - Screen dimensions: self.surface.get_width(), self.surface.get_height()
    
    Control commands:
    - self.snake.move_left()
    - self.snake.move_right()
    - self.snake.move_up()
    - self.snake.move_down()
    """
    # Your agent code here
```

### Helpful Utility Methods

The `Game` class provides several utility methods that your AI agent can use:

- `_calculate_distance(x1, y1, x2, y2)`: Calculate Euclidean distance between points
- `_get_potential_head(direction)`: Get coordinates of potential next head position
- `_is_potential_move_colliding(next_head_x, next_head_y)`: Check if a move leads to collision

## AI Agent Design Considerations

For optimal performance, your agent should balance:

1. **Pathfinding**: Navigate efficiently to the apple while avoiding obstacles
2. **Collision Avoidance**: Prevent wall and self-collisions
3. **Lookahead Planning**: Anticipate future moves to avoid dead ends
4. **Time Efficiency**: Prioritize shorter paths to maximize score/time ratio

## Evaluation Metrics

Performance of your AI agent will be measured by:

1. **Score**: Total number of apples eaten (snake length - 1)
2. **Time Efficiency**: Total game time or time per apple
3. **Score/Time Ratio**: Higher values indicate better performance

## Potential AI Approaches

1. **Rule-Based Systems**: Implement predefined rules and heuristics
2. **A* Search Algorithm**: Calculate optimal paths to the apple
3. **Reinforcement Learning**: Train an agent using rewards and penalties
4. **Deep Q-Learning**: Use neural networks to learn optimal state-action values
5. **Genetic Algorithms**: Evolve agent behavior through natural selection

## Getting Started with Your AI Agent

1. Understand the game mechanics and environment
2. Implement a simple agent (e.g., greedy approach)
3. Test and measure its performance
4. Iteratively improve by addressing performance bottlenecks
5. Experiment with more advanced AI techniques

Good luck creating your high-performance Snake Game AI agent!
