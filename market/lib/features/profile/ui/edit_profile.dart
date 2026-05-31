import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
	const EditProfile({super.key});

	@override
	State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
	final _formKey = GlobalKey<FormState>();
	final TextEditingController _nameCtrl = TextEditingController(text: 'John Doe');
	final TextEditingController _emailCtrl = TextEditingController(text: 'john.doe@example.com');
	final TextEditingController _phoneCtrl = TextEditingController();

	@override
	void dispose() {
		_nameCtrl.dispose();
		_emailCtrl.dispose();
		_phoneCtrl.dispose();
		super.dispose();
	}

	void _save() {
		if (_formKey.currentState?.validate() ?? false) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(content: Text('Profile saved')),
			);
			Navigator.of(context).pop();
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Edit Profile'),
				centerTitle: true,
				actions: [
					TextButton(
						onPressed: _save,
						child: const Text(
							'Save',
							style: TextStyle(color: Colors.white),
						),
					)
				],
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Form(
					key: _formKey,
					child: Column(
						children: [
							Center(
								child: Stack(
									alignment: Alignment.bottomRight,
									children: [
										const CircleAvatar(
											radius: 48,
											backgroundImage: AssetImage('assets/imgs/avatar_placeholder.png'),
										),
										IconButton(
											onPressed: () {},
											icon: const CircleAvatar(
												radius: 18,
												child: Icon(Icons.camera_alt, size: 18),
											),
										)
									],
								),
							),
							const SizedBox(height: 20),

							TextFormField(
								controller: _nameCtrl,
								decoration: const InputDecoration(labelText: 'Full name', border: OutlineInputBorder()),
								validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
							),
							const SizedBox(height: 12),

							TextFormField(
								controller: _emailCtrl,
								decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
								keyboardType: TextInputType.emailAddress,
								validator: (v) {
									if (v == null || v.trim().isEmpty) return 'Enter your email';
									if (!v.contains('@')) return 'Enter a valid email';
									return null;
								},
							),
							const SizedBox(height: 12),

							TextFormField(
								controller: _phoneCtrl,
								decoration: const InputDecoration(labelText: 'Phone', border: OutlineInputBorder()),
								keyboardType: TextInputType.phone,
							),

							const Spacer(),

							SizedBox(
								width: double.infinity,
								child: ElevatedButton(
									onPressed: _save,
									child: const Padding(
										padding: EdgeInsets.symmetric(vertical: 14.0),
										child: Text('Save changes'),
									),
								),
							),
						],
					),
				),
			),
		);
	}
}
