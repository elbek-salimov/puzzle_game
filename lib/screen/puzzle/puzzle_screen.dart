import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx/puzzle_controller.dart';

class PuzzleView extends StatelessWidget {
  const PuzzleView({super.key});

  @override
  Widget build(BuildContext context) {
    final PuzzleController controller =
        Get.put(PuzzleController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Game'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            color: Colors.black54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 10),
                  child: Center(
                    child: Obx(() => Text(
                          'Time: ${controller.elapsedTime} s',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 10),
                  child: Center(
                    child: Obx(() => Text(
                          'Move: ${controller.moveCount}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Obx(() => GridView.builder(
                        itemCount: controller.tiles.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: controller.gridSize,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 6),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => controller.moveTile(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color: controller.tiles[index] == 16
                                    ? Colors.transparent
                                    : Colors.teal,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                controller.tiles[index] == 16
                                    ? ''
                                    : controller.tiles[index].toString(),
                                style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          );
                        },
                      )),
                ),
              ),
            ),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.gameEnded.value
                  ? null
                  : () => controller.resetGame(),
              child: const Text('Restart'),
            ),
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}
