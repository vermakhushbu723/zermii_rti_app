import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_button.dart';

class AgentOnlineDesignForm extends StatefulWidget {
  const AgentOnlineDesignForm({super.key});

  @override
  State<AgentOnlineDesignForm> createState() => _AgentOnlineDesignFormState();
}

class _AgentOnlineDesignFormState extends State<AgentOnlineDesignForm> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _propertyTypeController = TextEditingController();
  final _areaController = TextEditingController();
  final _budgetController = TextEditingController();
  final _requirementsController = TextEditingController();

  String _selectedDesignType = 'Interior Design';

  @override
  void dispose() {
    _customerNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _propertyTypeController.dispose();
    _areaController.dispose();
    _budgetController.dispose();
    _requirementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Online Design Form'),
        backgroundColor: AppColors.agentModule,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customer Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _customerNameController,
                labelText: 'Customer Name',
                prefixIcon: Icons.person_outline,
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _phoneController,
                labelText: 'Phone Number',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              const Text(
                'Project Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDesignType,
                decoration: const InputDecoration(
                  labelText: 'Design Type',
                  border: OutlineInputBorder(),
                ),
                items:
                    [
                          'Interior Design',
                          '3D Design',
                          'Architecture',
                          'Space Planning',
                        ]
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                onChanged: (v) => setState(() => _selectedDesignType = v!),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _propertyTypeController,
                labelText: 'Property Type',
                prefixIcon: Icons.home_outlined,
                hintText: 'e.g., Apartment, Villa, Office',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _areaController,
                labelText: 'Area (sq ft)',
                prefixIcon: Icons.square_foot_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _budgetController,
                labelText: 'Budget (₹)',
                prefixIcon: Icons.currency_rupee,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _requirementsController,
                labelText: 'Requirements',
                prefixIcon: Icons.notes_outlined,
                maxLines: 4,
                hintText: 'Describe your design requirements...',
              ),
              const SizedBox(height: 24),
              CustomButton(text: 'Submit Request', onPressed: _handleSubmit),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Design request submitted successfully!')),
      );
      Navigator.pop(context);
    }
  }
}
