import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/models/note.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightBlue.shade300,
  Colors.lightGreen.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100,
];

class NoteCardWidget extends StatelessWidget {
  final Note note;
  final int index;

  const NoteCardWidget({
    super.key,
    required this.note,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().add_jms().format(note.createdTime);
    final minHeight = _getMinHeightPattern(index);
    // If note.number == 0 -> use _lightColors (default color set),
    // otherwise use color mapped by priority
    final color = (note.number <= 0)
        ? _lightColors[index % _lightColors.length]
        : _getPriorityColor(note.number);

    return Card(
      color: color,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.all(8),
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Timestamp
            Text(
              time,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 6),

            // Title + important icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    note.title.isNotEmpty ? note.title : '(No title)',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (note.isImportant)
                  const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Icon(Icons.star, color: Colors.red, size: 20),
                  ),
              ],
            ),

            const SizedBox(height: 8),

            // Description (short)
            Text(
              note.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 10),

            // Priority row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Priority: ${note.number}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // small colored flag indicator (same hue as priority color but slightly darker)
                Icon(
                  Icons.flag,
                  size: 16,
                  color: (note.number <= 0)
                      ? Colors.black26
                      : _getPriorityColor(note.number).withOpacity(0.85),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Pattern: 0 -> small, 1 -> tall, 2 -> tall, 3 -> small, repeat...
  double _getMinHeightPattern(int index) {
    switch (index % 4) {
      case 0:
        return 110; // small
      case 1:
        return 220; // tall
      case 2:
        return 200; // tall
      case 3:
        return 120; // small
      default:
        return 120;
    }
  }

  // Priority color mapping (used only when number > 0)
  Color _getPriorityColor(int priority) {
    switch (priority.clamp(0, 5)) {
      case 5:
        return Colors.red.shade200;
      case 4:
        return Colors.orange.shade200;
      case 3:
        return Colors.yellow.shade200;
      case 2:
        return Colors.lightGreen.shade200;
      case 1:
        return Colors.lightBlue.shade200;
      default:
        return Colors.grey.shade300;
    }
  }
}