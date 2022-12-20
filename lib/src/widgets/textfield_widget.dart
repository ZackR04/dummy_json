part of 'x_widgets.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String title;
  final bool? isPassword;
  final bool? isEnabled;
  final int? maxLines;
  const TextFieldWidget(
      {super.key,
        required this.controller,
        required this.hint,
        required this.title,
        this.isPassword = false,
        this.isEnabled = true,
        this.maxLines = 1});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: const TextStyle(fontSize: 18),),
        const SizedBox(
          height: 12,
        ),
        TextField(
          controller: widget.controller,
          enabled: widget.isEnabled!,
          maxLines: widget.maxLines,
          textAlignVertical: TextAlignVertical.center,
          obscureText: (widget.isPassword!) ? isObscure : false,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.black,
                      width: 0.5
                  )
              ),
              hintText: widget.hint,
              suffixIcon: (widget.isPassword!)
                  ? IconButton(
                  icon:
                  Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  })
                  : const SizedBox()),
        ),
      ],
    );
  }
}
