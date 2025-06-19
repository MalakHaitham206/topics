// pages/form_page.dart
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _websiteController = TextEditingController();
  
  String _selectedCountry = 'United States';
  String _selectedGender = 'Prefer not to say';
  DateTime? _selectedDate;
  bool _receiveNotifications = true;
  bool _agreeToTerms = false;
  double _experienceYears = 0;
  List<String> _selectedSkills = [];
  
  final List<String> _countries = [
    'United States', 'Canada', 'United Kingdom', 'Germany', 
    'France', 'Australia', 'Japan', 'India', 'Brazil', 'Other'
  ];
  
  final List<String> _genders = [
    'Male', 'Female', 'Non-binary', 'Prefer not to say'
  ];
  
  final List<String> _availableSkills = [
    'Flutter', 'Dart', 'React', 'JavaScript', 'Python', 
    'Java', 'Swift', 'Kotlin', 'UI/UX Design', 'Project Management'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      // Here you would typically use Provider to save the form data
      _showSuccessDialog();
    } else if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the terms and conditions'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Form Submitted Successfully!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${_nameController.text}'),
            Text('Email: ${_emailController.text}'),
            Text('Country: $_selectedCountry'),
            Text('Skills: ${_selectedSkills.join(', ')}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration Form'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person_add,
                        size: 48,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create Your Profile',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Fill in your details to get started',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Basic Information Section
              _buildSectionTitle('Basic Information'),
              const SizedBox(height: 12),
              
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address *',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              // Personal Details Section
              _buildSectionTitle('Personal Details'),
              const SizedBox(height: 12),
              
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  prefixIcon: Icon(Icons.flag),
                  border: OutlineInputBorder(),
                ),
                items: _countries.map((country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value!;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                items: _genders.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _selectedDate == null
                        ? 'Select your date of birth'
                        : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    style: _selectedDate == null
                        ? TextStyle(color: Colors.grey[600])
                        : null,
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Professional Information Section
              _buildSectionTitle('Professional Information'),
              const SizedBox(height: 12),
              
              TextFormField(
                controller: _websiteController,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Website/Portfolio',
                  prefixIcon: Icon(Icons.link),
                  border: OutlineInputBorder(),
                  hintText: 'https://yourwebsite.com',
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(r'^https?://').hasMatch(value)) {
                      return 'Please enter a valid URL starting with http:// or https://';
                    }
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Years of Experience: ${_experienceYears.round()}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Slider(
                value: _experienceYears,
                min: 0,
                max: 30,
                divisions: 30,
                label: '${_experienceYears.round()} years',
                onChanged: (value) {
                  setState(() {
                    _experienceYears = value;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Skills & Technologies',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _availableSkills.map((skill) {
                  final isSelected = _selectedSkills.contains(skill);
                  return FilterChip(
                    label: Text(skill),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedSkills.add(skill);
                        } else {
                          _selectedSkills.remove(skill);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 20),
              
              // Bio Section
              _buildSectionTitle('About You'),
              const SizedBox(height: 12),
              
              TextFormField(
                controller: _bioController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Bio/Description',
                  hintText: 'Tell us about yourself, your interests, and goals...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value != null && value.length > 500) {
                    return 'Bio must be less than 500 characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              // Preferences Section
              _buildSectionTitle('Preferences'),
              const SizedBox(height: 12),
              
              SwitchListTile(
                title: const Text('Receive Email Notifications'),
                subtitle: const Text('Get updates about new features and opportunities'),
                value: _receiveNotifications,
                onChanged: (value) {
                  setState(() {
                    _receiveNotifications = value;
                  });
                },
              ),
              
              CheckboxListTile(
                title: const Text('I agree to the Terms and Conditions *'),
                subtitle: const Text('Required to create account'),
                value: _agreeToTerms,
                onChanged: (value) {
                  setState(() {
                    _agreeToTerms = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              
              const SizedBox(height: 30),
              
              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              
              const SizedBox(height: 16),
              
              OutlinedButton(
                onPressed: () {
                  _formKey.currentState!.reset();
                  setState(() {
                    _nameController.clear();
                    _emailController.clear();
                    _phoneController.clear();
                    _bioController.clear();
                    _websiteController.clear();
                    _selectedCountry = 'United States';
                    _selectedGender = 'Prefer not to say';
                    _selectedDate = null;
                    _receiveNotifications = true;
                    _agreeToTerms = false;
                    _experienceYears = 0;
                    _selectedSkills.clear();
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Reset Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Icon(
          Icons.chevron_right,
          color: Theme.of(context).primaryColor,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}