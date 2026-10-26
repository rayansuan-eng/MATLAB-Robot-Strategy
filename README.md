# Autonomous Robot Strategy in MATLAB

A decision-making strategy for a simulated robot competition, developed for the Signals and Systems course at Ruppin Academic Center.

Two robots compete on a randomized map containing fuel tanks and mines. My strategy balances collecting fuel with pursuing the opponent, avoiding mines, and conserving fuel when resources run out.

The strategy placed **1st among current-year teams** and **2nd when previous-year winners were included**.

[Watch the demonstration on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7519398908943552512/).

## Strategy

`MyRobotStrategy2.m` receives the game environment and memory from the previous turn, then returns a two-component movement vector and updated memory.

- **Fuel selection:** scores available tanks using `distance_from_me - 0.3 * distance_from_opponent`.
- **Opponent prediction:** when the opponent is closer to the selected tank, estimates its position three maximum-length steps along that direction.
- **Attack decisions:** considers the fuel advantage, estimated pursuit cost, current distance, and whether a chase is already underway.
- **Mine avoidance:** checks the planned route against active mines and adjusts the destination for up to three iterations.
- **Escape behavior:** detects repeated lack of movement and evaluates alternative directions for mine clearance.
- **Endgame behavior:** pursues the opponent when ahead; when behind with no fuel remaining, selects a defensive destination or stands still to conserve movement fuel.

Destinations are clamped inside the 10-by-10 arena, and the returned movement magnitude is limited to the engine's maximum step length. These are heuristic decisions, not guarantees of collision-free navigation or victory on every map.

## Run the demo

Requires MATLAB with desktop graphics support. The original competition package uses legacy plotting code; its compatibility with a particular MATLAB release should be checked locally.

1. Download or clone the repository.
2. Set MATLAB's **Current Folder** to the repository folder.
3. Run:

```matlab
run_demo
```

This starts `MyRobotStrategy2` against the supplied random opponent. The robot names and colors are configured in `run_demo.m`.

To try another opponent, change the second team's `strategy` handle and display name in `run_demo.m`:

| Function handle | Opponent |
| --- | --- |
| `@robostrategy_rand` | Random movement |
| `@robostrategy_nomove` | Stationary robot |
| `@robostrategy_direct` | Simple preset movement with boundary checks |
| `@robostrategy_good` | Supplied compiled opponent (`.p` file; MATLAB compatibility may vary) |

Maps and initial positions are randomized. For repeatable trials, enter `rng(42)` before `run_demo`, and use the same opponent and settings.

The original `rungame.m` is also included. It runs three matches between the supplied sample strategies; it does **not** run `MyRobotStrategy2`.

## Default simulator behavior

The supplied `robotgame_main.m` initializes both robots with 1,000 fuel units, 24 mines, and 16 fuel tanks. Default maximum movement is 0.25 units per turn. Movement costs five fuel units per unit of distance, plus a base consumption of two fuel units per turn.

A mine costs 20 fuel units and a fuel tank adds 30. The game ends when the robots are closer than twice their radius (0.6 units with the supplied defaults), or a robot's fuel becomes negative. The robot with more fuel wins.

These values describe the included simulator. Some descriptions in the older handout and strategy comments differ from the engine, including the ending distance and use of memory. The simulator explicitly passes memory between turns; the strategy uses that interface.

## Files and attribution

| File | Origin and purpose |
| --- | --- |
| `MyRobotStrategy2.m` | Rayan Suan's robot strategy |
| `run_demo.m` | Added portfolio launcher for the strategy |
| `robotgame_main.m` | Course-provided simulator |
| `robostrategy_*.m` | Course-provided sample opponents |
| `robostrategy_good.p` | Course-provided compiled opponent; source is not included |
| `rungame.m` | Original sample-match launcher |
| `docs/strategy-presentation.pptx` | Original strategy presentation |
| `docs/robot-competition-overview.pdf` | Original competition overview in Hebrew |
| `docs/competition-instructions.pdf` | Original course instructions in Hebrew |

The strategy and course simulator files are preserved from the uploaded archives. The preparation adds documentation, the demo launcher, and ignore rules, removes macOS metadata, and gives the reference documents readable filenames.

## Verification

The package was checked for matching function filenames, the strategy/environment interface, and local dependencies. MATLAB is not available in the preparation environment, so the demo and full matches have not been rerun as part of this packaging step. The competition placement above reflects the original course result, not new benchmark results.

The course simulator, sample opponents, and teaching materials are credited separately from the strategy. No new license is applied to those supplied materials.
