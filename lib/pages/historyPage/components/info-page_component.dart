import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:src/l10n/app_localizations.dart';


class InfoPageHistoryComponent extends StatelessWidget {
  const InfoPageHistoryComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 16),
          _buildImage(),
          SizedBox(height: 16),
          _buildTitleText(context),
          SizedBox(
            height: 16,
          ),
          _buildSubTitle(context),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      alignment: Alignment.centerLeft,
      child:SvgPicture.asset('lib/assets/images/history.svg',
          semanticsLabel: "History", height: 120)
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child:  Text(
        AppLocalizations.of(context)!.history,
        style: TextStyle(
          color: Colors.black,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSubTitle(BuildContext context) {
    return Container(
      child: Text(
        AppLocalizations.of(context)!.historySubTitle,
        style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.5
        ),
      ),
    );
  }
}
