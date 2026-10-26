import 'package:flutter/material.dart';

class DetectionItem {
  final String label;
  final double confidence;
  final Rect? box;

  DetectionItem({
    required this.label,
    required this.confidence,
    this.box,
  });
}
