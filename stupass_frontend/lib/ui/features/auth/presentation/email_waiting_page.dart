import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/routing/routes.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/email_waiting_view_model.dart';

class EmailWaitingPage extends StatefulWidget {
  final EmailWaitingViewModel viewModel;

  const EmailWaitingPage({
    super.key,
    required this.viewModel,
  });

  @override
  State<EmailWaitingPage> createState() => _EmailWaitingPageState();
}

class _EmailWaitingPageState extends State<EmailWaitingPage> {
  @override
  void initState() {
    super.initState();
    
    // 1. Start the Rust server polling the moment the screen loads
    widget.viewModel.startListeningForVerification();

    // 2. Add a listener to trigger the automatic navigation
    widget.viewModel.addListener(_onViewModelChange);
  }

  @override
  void dispose() {
    // Always clean up listeners to prevent memory leaks!
    widget.viewModel.removeListener(_onViewModelChange);
    super.dispose();
  }

  void _onViewModelChange() {
    // If the polling timer flips this to true, magically navigate away
    if (widget.viewModel.isVerified && mounted) {
      widget.viewModel.removeListener(_onViewModelChange); // Stop listening
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email verified successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      widget.viewModel.cancelRegistration();
      context.go(Routes.signin);
    }
  }

  Future<void> _resendLink() async {
    // Let the ViewModel do all the heavy lifting
    final success = await widget.viewModel.resendVerificationEmail();

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A new verification link has been sent!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.viewModel.errorMessage ?? 'Failed to resend')),
      );
      widget.viewModel.clearError();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 3. Wrap the body in a ListenableBuilder
    // This ensures ONLY the UI redraws when the ViewModel calls notifyListeners()
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlpha(10),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mark_email_unread_rounded,
                      size: 80,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  const Text(
                    'Check your inbox',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
                      children: [
                        const TextSpan(text: 'We\'ve sent a verification link to\n'),
                        TextSpan(
                          // Ensure your ViewModel exposes the email string!
                          text: widget.viewModel.email, 
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const TextSpan(text: '\n\nPlease click the link in the email to verify your account.'),
                      ],
                    ),
                  ),
                  
                  const Spacer(),
                  
                  TextButton(
                    onPressed: widget.viewModel.isResending ? null : _resendLink,
                    child: widget.viewModel.isResending
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            'Resend Link',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                  ),
                  
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}