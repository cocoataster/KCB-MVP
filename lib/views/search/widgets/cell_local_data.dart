import 'package:flutter/material.dart';
import 'package:sounds_good/core/utils/text_styles.dart';

class CellLocalData extends StatelessWidget {
  final String name;
  final double price;
  final description;

  CellLocalData({this.name, this.price, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: MemberName(name: name),
                ),
                Expanded(flex: 9, child: MemberPrice(price: price)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: MemberDescription(
                    description: description,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MemberName extends StatelessWidget {
  final String name;
  MemberName({this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyles.section_header,
      textAlign: TextAlign.start,
    );
  }
}

class MemberPrice extends StatelessWidget {
  final double price;
  const MemberPrice({this.price});

  @override
  Widget build(BuildContext context) {
    return Text('$price€/h',
        style: TextStyles.section_subHeader, textAlign: TextAlign.right);
  }
}

class MemberDescription extends StatelessWidget {
  final String description;

  MemberDescription({this.description});

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [Text('${description.substring(0, 160)}...')]);
  }
}
