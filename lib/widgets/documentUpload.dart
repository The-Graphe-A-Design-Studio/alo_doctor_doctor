import 'package:flutter/material.dart';

class documentUpload extends StatefulWidget {
  String label;
  bool isSelected;
  Function onTap;
  documentUpload({
    this.label,
    this.isSelected,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  _documentUploadState createState() => _documentUploadState();
}

class _documentUploadState extends State<documentUpload> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: widget.isSelected
                      ? <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.16),
                              blurRadius: 1,
                              offset: Offset(0, 4))
                        ]
                      : null,
                  color: widget.isSelected
                      ? Color(0xffE9F98F)
                      : Colors.transparent,
                  border: Border.all(
                      color: widget.isSelected
                          ? Color(0xffE9F98F)
                          : Color(0xffDFF4F3),
                      width: 1),
                  borderRadius: BorderRadius.circular(20)),
              width: double.infinity,
              height: 38,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(widget.isSelected
                          ? 'assets/images/imagejpgselected.png'
                          : 'assets/images/imagejpg.png'),
                    ),
                    SizedBox(
                      width: 26,
                    ),
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: widget.isSelected
                            ? Colors.black
                            : Color(0xff8C8FA5),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(child: Container()),
                    Text(
                      "500 KB",
                      style: TextStyle(
                        color: widget.isSelected
                            ? Colors.black
                            : Color(0xff8C8FA5),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(child: Container()),
            Visibility(
              child: Text(
                'Choose from gallery',
                style: TextStyle(
                    color: Color(0xff8C8FA5),
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              visible: widget.isSelected,
            ),
          ],
        )
      ],
    );
  }
}
