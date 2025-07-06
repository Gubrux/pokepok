import 'package:flutter/material.dart';

class StatsTable extends StatelessWidget {
  final String attack;
  final String defense;
  final String hp;
  final String type;
  final Color backgroundColor;
  const StatsTable({super.key, required this.attack, required this.defense, required this.hp, required this.type, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    const double cellHeight = 56;
    const double cellWidth = 140;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatRow(
                label: 'Attack',
                value: attack,
                highlighted: true,
                width: cellWidth,
                height: cellHeight,
                backgroundColor: backgroundColor,
              ),
              StatRow(
                label: 'Defense',
                value: defense,
                highlighted: true,
                width: cellWidth,
                height: cellHeight,
                backgroundColor: backgroundColor,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatRow(
                label: 'HP',
                value: hp,
                highlighted: true,
                width: cellWidth,
                height: cellHeight,
                backgroundColor: backgroundColor,
              ),
              StatSingleCell(
                text: 'Type: ${type[0].toUpperCase() + type.substring(1)}',
                width: cellWidth,
                height: cellHeight,
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              onPressed: () {},
              child: const Text(
                'Yo te elijo!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlighted;
  final double width;
  final double height;
  final Color backgroundColor;

  const StatRow({
    required this.label,
    required this.value,
    this.highlighted = false,
    required this.width,
    required this.height,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: highlighted ? backgroundColor : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
                border: Border.all(color: Colors.grey[300]!),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: highlighted ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                border: Border.all(color: Colors.grey[300]!),
              ),
              alignment: Alignment.center,
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatSingleCell extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  const StatSingleCell({
    required this.text,
    required this.width,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey[300]!),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
