import 'package:flutter/material.dart';
import '../models/app_models.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage>
    with TickerProviderStateMixin {
  final CounterModel counter = CounterModel();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateCounter() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Demo'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green[600]!,
              Colors.green[400]!,
              Colors.green[200]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Current Count',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${counter.counter}',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.remove,
                    onPressed: () {
                      setState(() {
                        counter.decrement();
                      });
                      _animateCounter();
                    },
                    color: Colors.red,
                  ),
                  _buildActionButton(
                    icon: Icons.refresh,
                    onPressed: () {
                      setState(() {
                        counter.reset();
                      });
                      _animateCounter();
                    },
                    color: Colors.blue,
                  ),
                  _buildActionButton(
                    icon: Icons.add,
                    onPressed: () {
                      setState(() {
                        counter.increment();
                      });
                      _animateCounter();
                    },
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Counter Statistics',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Current Value:'),
                        Text(
                          '${counter.counter}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Is Positive:'),
                        Text(
                          counter.counter > 0 ? 'Yes' : 'No',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: counter.counter > 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Is Even:'),
                        Text(
                          counter.counter % 2 == 0 ? 'Yes' : 'No',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: color,
      heroTag: icon.toString(),
      child: Icon(icon, color: Colors.white),
    );
  }
}