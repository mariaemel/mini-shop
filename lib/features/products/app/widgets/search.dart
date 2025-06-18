import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const Search({super.key, required this.controller, required this.onChanged});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    super.dispose();
  }

  void _handleTextChange() {
    widget.onChanged(widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: widget.controller,
        decoration: const InputDecoration(
          labelText: 'Найти',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
