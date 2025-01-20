// Lucia Raciti
// Fundamentals of Computing
// 12/15/24
// Flappy Bird Mini Project Game that uses two structs, an array, and a visual screen

#include "gfx2.h"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>

// Structs
typedef struct {
  float x;
  float y;
  float velocity;
} Bird;

typedef struct {
  float x;
  int gap;
  int passed;
} Pipe;

// Function Calls
void startDisplay();
int GameOver(int score, int highScore);
void resetGame(Bird *bird, Pipe pipes[], int *score, int pipeCount, int height, int pipeSpacing, int pipeGap, int width);
void initialPipes(Pipe pipes[], int pipeCount, int width, int height, int pipeSpacing, int pipeGap);
void changePipes(Pipe pipes[], int pipeCount, int height, int pipeSpacing, int pipeWidth, int pipeGap, int pipeSpeed);
int checkCollisions(Bird bird, Pipe pipes[], int birdRadius, int height, int pipeCount, int pipeWidth, int pipeGap);
void drawPipes(Pipe pipes[], int pipeCount, int pipeWidth, int pipeGap, int height);
void drawBird(Bird bird, int birdRadius);

int main()
{
  srand(time(NULL));

  int width = 800, height = 500;

  // Score variables
  int highScore = 0;
  int score = 0;

  // Flappy Bird struct and variables
  Bird bird = {150, 250, 0}; // Initialize bird
  int birdRadius = 10; // radius of bird
  float flap = -9; // amount of distance you go with each space bar click
  float gravity = 0.6; // how much bird decreases each round

  // Pipe variables
  int pipeCount = 5; // amount of pipes in the loop
  int pipeWidth = 40; // width of pipes
  int pipeGap = 150; // gap between the two bars
  int pipeSpacing = 200;  // spacing between each pipe set
  int pipeSpeed = 2; // speed of game pipes
  Pipe pipes[pipeCount];

  // Input variable
  char c;

  gfx_open(width, height, "Flappy Bird");

  initialPipes(pipes, pipeCount, width, height, pipeSpacing, pipeGap);

  startDisplay();
  gfx_color(0, 255, 0);

  int quit = 0;

  // Intro Screen
  while (1) {
    if (gfx_event_waiting()) {
      c = gfx_wait();
      if (c == ' ') break;
      if (c == 'q') return 0;
    }
  }

  // Game Loop
  while (!quit) {
    gfx_clear();

    if (gfx_event_waiting()) {
      c = gfx_wait();
      if (c == ' ') bird.velocity = flap; // Flap
      if (c == 'q') break; // Quit game
    }

    // Update bird position
    bird.velocity += gravity;
    bird.y += bird.velocity;

    // Update pipe positions
    changePipes(pipes, pipeCount, height, pipeSpacing, pipeWidth, pipeGap, pipeSpeed);

    // Change score
    for (int i = 0; i < pipeCount; i++) {
      if (pipes[i].x + pipeWidth < bird.x && !pipes[i].passed) {
        score++;
        pipes[i].passed = 1;
      }
    }

    // Check for collisions
    if (checkCollisions(bird, pipes, birdRadius, height, pipeCount, pipeWidth, pipeGap)) {
      if (score > highScore) highScore = score;
      quit = GameOver(score, highScore);
      resetGame(&bird, pipes, &score, pipeCount, height, pipeSpacing, pipeGap, width);
      startDisplay();
    }

    // Draw bird
    drawBird(bird, birdRadius);

    // Draw pipes
    drawPipes(pipes, pipeCount, pipeWidth, pipeGap, height);

    // Display score
    char scoreText[50];
    sprintf(scoreText, "Score: %d", score);
    gfx_text(20, 20, scoreText);

    gfx_flush();
    usleep(20000);
  }

  return 0;
}

// Display for Starting Window
void startDisplay()
{
  gfx_clear();
  gfx_text(360, 250, "Flappy Bird");
  gfx_text(325, 300, "Press SPACE bar to start game");
  gfx_flush();
}

// Game over Screen with score and high score
int GameOver(int score, int highScore)
{
  gfx_clear();
  char scoreText[50];
  sprintf(scoreText, "GAME OVER! Score: %d", score);
  gfx_text(325, 250, scoreText);
  char HighText[50];
  sprintf(HighText, "High Score: %d", highScore);
  gfx_text(345, 275, HighText);
  gfx_text(280, 325, "Press SPACE to restart game or q to quit");

  gfx_flush();
  char c;
  while (1) {
    if (gfx_event_waiting()) {
      c = gfx_wait();
      if (c == ' ') return 0;
      if (c == 'q') return 1;
    }
  }
}

// Resets game to original state
void resetGame(Bird *bird, Pipe pipes[], int *score, int pipeCount, int height, int pipeSpacing, int pipeGap, int width)
{
  bird->x = 150;
  bird->y = 250;
  bird->velocity = 0;
  initialPipes(pipes, pipeCount, width, height, pipeSpacing, pipeGap);
  *score = 0;
}

void initialPipes(Pipe pipes[], int pipeCount, int width, int height, int pipeSpacing, int pipeGap)
{
  for (int i = 0; i < pipeCount; i++) {
    pipes[i].x = width + i * pipeSpacing;
    pipes[i].gap = rand() % (height - pipeGap - 100) + 50; // Adjustable limits
    pipes[i].passed = 0;
  }
}

// Updates pipes locations
void changePipes(Pipe pipes[], int pipeCount, int height, int pipeSpacing, int pipeWidth, int pipeGap, int pipeSpeed)
{
  for (int i = 0; i < pipeCount; i++) {
    pipes[i].x -= pipeSpeed;
    if (pipes[i].x + pipeWidth < 0) {
      pipes[i].x += pipeCount * pipeSpacing;
      pipes[i].gap = rand() % (height - pipeGap - 100) + 50;
      pipes[i].passed = 0;
    }
  }
}

// checks for collision with bottom of screen or one of the pipes
int checkCollisions(Bird bird, Pipe pipes[], int birdRadius, int height, int pipeCount, int pipeWidth, int pipeGap)
{
  if (bird.y + birdRadius > height) return 1;

  for (int i = 0; i < pipeCount; i++) {
    if (bird.x + birdRadius > pipes[i].x && bird.x - birdRadius < pipes[i].x + pipeWidth) {
      if (bird.y - birdRadius < pipes[i].gap || bird.y + birdRadius > pipes[i].gap + pipeGap) return 1;
    }
  }
  return 0;
}

// Draw Pipes
void drawPipes(Pipe pipes[], int pipeCount, int pipeWidth, int pipeGap, int height)
{
  for (int i = 0; i < pipeCount; i++) {
    gfx_fill_rectangle(pipes[i].x, 0, pipeWidth, pipes[i].gap);
    gfx_fill_rectangle(pipes[i].x, pipes[i].gap + pipeGap, pipeWidth, height-(pipes[i].gap+pipeGap));
  }
}

// Draw Bird
void drawBird(Bird bird, int birdRadius)
{
  gfx_fill_circle(bird.x, bird.y, birdRadius);

  // beak
  gfx_line(bird.x+birdRadius, bird.y+4, bird.x+birdRadius+6, bird.y);
  gfx_line(bird.x+birdRadius+6, bird.y, bird.x+birdRadius, bird.y-4);
  gfx_line(bird.x+birdRadius, bird.y-4, bird.x+birdRadius, bird.y+4); 

  // tail
  gfx_line(bird.x-birdRadius, bird.y, bird.x-birdRadius-8, bird.y+5);
  gfx_line(bird.x-birdRadius-8, bird.y+5, bird.x-birdRadius-8, bird.y-5);
  gfx_line(bird.x-birdRadius-8, bird.y-5, bird.x-birdRadius, bird.y);
}
