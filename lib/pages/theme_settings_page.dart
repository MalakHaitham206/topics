import 'package:flutter/material.dart';

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({super.key});

  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  // These will be managed by Provider in your implementation
  bool isDarkMode = false;
  Color primaryColor = Colors.blue;
  double fontSize = 14.0;
  String fontFamily = 'Default';
  bool useSystemTheme = true;
  bool highContrast = false;
  bool reduceAnimations = false;
  double borderRadius = 12.0;
  bool compactMode = false;
  
  // Color options
  final List<Color> colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.indigo,
    Colors.pink,
  ];
  
  // Font family options
  final List<String> fontFamilies = [
    'Default',
    'Roboto',
    'Arial',
    'Helvetica',
    'Times New Roman',
    'Georgia',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Theme Settings'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetToDefaults,
            tooltip: 'Reset to defaults',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Preview Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.palette,
                        color: primaryColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Theme Preview',
                        style: TextStyle(
                          fontSize: fontSize + 4,
                          fontWeight: FontWeight.bold,
                          fontFamily: fontFamily == 'Default' ? null : fontFamily,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'This is how your app will look with the current theme settings. You can customize colors, fonts, and other visual elements.',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontFamily: fontFamily == 'Default' ? null : fontFamily,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                          ),
                          child: Text(
                            'Primary Button',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: fontFamily == 'Default' ? null : fontFamily,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                          ),
                          child: Text(
                            'Outlined Button',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: fontFamily == 'Default' ? null : fontFamily,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Theme Mode Section
            _buildSection(
              title: 'Appearance',
              children: [
                _buildSwitchTile(
                  icon: Icons.phone_android,
                  title: 'Use System Theme',
                  subtitle: 'Follow system dark/light mode',
                  value: useSystemTheme,
                  onChanged: (value) {
                    setState(() {
                      useSystemTheme = value;
                    });
                  },
                ),
                if (!useSystemTheme) ...[
                  _buildDivider(),
                  _buildSwitchTile(
                    icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    title: 'Dark Mode',
                    subtitle: 'Enable dark theme',
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                ],
                _buildDivider(),
                _buildSwitchTile(
                  icon: Icons.contrast,
                  title: 'High Contrast',
                  subtitle: 'Increase contrast for better visibility',
                  value: highContrast,
                  onChanged: (value) {
                    setState(() {
                      highContrast = value;
                    });
                  },
                ),
              ],
            ),
            
            // Color Customization Section
            _buildSection(
              title: 'Colors',
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.color_lens, color: primaryColor),
                          const SizedBox(width: 12),
                          Text(
                            'Primary Color',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: colorOptions.map((color) {
                          final isSelected = color == primaryColor;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                primaryColor = color;
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: isSelected
                                    ? Border.all(color: Colors.white, width: 3)
                                    : null,
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: color.withOpacity(0.5),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                    : null,
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Typography Section
            _buildSection(
              title: 'Typography',
              children: [
                ListTile(
                  leading: Icon(Icons.text_fields, color: primaryColor),
                  title: const Text('Font Size'),
                  subtitle: Text('${fontSize.toInt()}px'),
                  trailing: SizedBox(
                    width: 150,
                    child: Slider(
                      value: fontSize,
                      min: 10.0,
                      max: 20.0,
                      divisions: 10,
                      label: '${fontSize.toInt()}px',
                      activeColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          fontSize = value;
                        });
                      },
                    ),
                  ),
                ),
                _buildDivider(),
                ListTile(
                  leading: Icon(Icons.font_download, color: primaryColor),
                  title: const Text('Font Family'),
                  subtitle: Text(fontFamily),
                  trailing: DropdownButton<String>(
                    value: fontFamily,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          fontFamily = value;
                        });
                      }
                    },
                    items: fontFamilies.map((font) {
                      return DropdownMenuItem(
                        value: font,
                        child: Text(
                          font,
                          style: TextStyle(
                            fontFamily: font == 'Default' ? null : font,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            
            // Layout Section
            _buildSection(
              title: 'Layout',
              children: [
                ListTile(
                  leading: Icon(Icons.rounded_corner, color: primaryColor),
                  title: const Text('Corner Radius'),
                  subtitle: Text('${borderRadius.toInt()}px'),
                  trailing: SizedBox(
                    width: 150,
                    child: Slider(
                      value: borderRadius,
                      min: 0.0,
                      max: 24.0,
                      divisions: 12,
                      label: '${borderRadius.toInt()}px',
                      activeColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          borderRadius = value;
                        });
                      },
                    ),
                  ),
                ),
                _buildDivider(),
                _buildSwitchTile(
                  icon: Icons.compress,
                  title: 'Compact Mode',
                  subtitle: 'Reduce spacing between elements',
                  value: compactMode,
                  onChanged: (value) {
                    setState(() {
                      compactMode = value;
                    });
                  },
                ),
              ],
            ),
            
            // Accessibility Section
            _buildSection(
              title: 'Accessibility',
              children: [
                _buildSwitchTile(
                  icon: Icons.animation,
                  title: 'Reduce Animations',
                  subtitle: 'Minimize motion for better accessibility',
                  value: reduceAnimations,
                  onChanged: (value) {
                    setState(() {
                      reduceAnimations = value;
                    });
                  },
                ),
              ],
            ),
            
            // Action Buttons
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveThemeSettings,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                      child: const Text('Save Settings'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _exportTheme,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: primaryColor),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                      child: Text(
                        'Export Theme',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize + 2,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
                fontFamily: fontFamily == 'Default' ? null : fontFamily,
              ),
            ),
          ),
          ...children,
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily == 'Default' ? null : fontFamily,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),  
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: fontSize - 2,
          fontFamily: fontFamily == 'Default' ? null : fontFamily,
          color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
        inactiveTrackColor: isDarkMode ? Colors.grey[700] : Colors.grey[300],
      ),
    );
  }
  Widget _buildDivider() {
    return Divider(
      color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
    );
  }
  void _resetToDefaults() {
    setState(() {
      isDarkMode = false;
      primaryColor = Colors.blue;
      fontSize = 14.0;
      fontFamily = 'Default';
      useSystemTheme = true;
      highContrast = false;
      reduceAnimations = false;
      borderRadius = 12.0;
      compactMode = false;
    });
  }

  void _saveThemeSettings() {
    // Here you would typically save the settings to a persistent storage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('Theme settings saved successfully!')),
    );
  }
  void _exportTheme() {
    // Here you would typically export the theme settings to a file or share them
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('Theme settings exported successfully!')),
    );
  }

  @override
  void dispose() {
    // Dispose any controllers or resources if needed
    super.dispose();
  } 
}