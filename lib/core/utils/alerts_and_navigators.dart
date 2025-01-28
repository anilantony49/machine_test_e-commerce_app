
import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/colors.dart';
import 'package:machine_test/core/utils/constants.dart';
import 'package:machine_test/core/utils/text.dart';

class CartActions {
  static void removeItemsAndShowSnackbar(BuildContext context, String itemId) {
    // CartDb.singleton.removeCart(itemId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppText.itemRemovedText),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

customSnackbar(BuildContext context, String message,
    {IconData? leading, String? trailing}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      backgroundColor: Appcolor.dLightBlueGrey2,
      dismissDirection: DismissDirection.up,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          if (leading != null)
            Icon(
              leading,
              color: Colors.white,
            ),
          kWidth(10),
          SizedBox(
            width: MediaQuery.of(context).size.width - 150,
            child: Text(
              message,
              // overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          if (trailing != null)
            Text(
              trailing,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Colors.white,
              ),
            )
        ],
      ),
    ),
  );
}
class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final bool disableTitle;
  final String? description;
  final double? descriptionTxtSize;
  final bool? disableActionBtn;
  final bool? disablePopupBtn;
  final String? popBtnText;
  final Function()? onTap;
  final String? actionBtnTxt;
  const CustomAlertDialog({
    super.key,
    this.title,
    this.disableTitle = true,
    this.description,
    this.descriptionTxtSize,
    this.onTap,
    this.disablePopupBtn = false,
    this.disableActionBtn = false,
    this.popBtnText,
    this.actionBtnTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: disableTitle ? 15 : 0),
          disableTitle
              ? Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : const SizedBox(),
          kHeight(12),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Text(
              description ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: descriptionTxtSize ?? 13,
                  color: Colors.white),
            ),
          ),
          kHeight(10),
          Divider(
            height: 1,
            color:  Colors.white,
          ),
          disableActionBtn == false
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: InkWell(
                    onTap: onTap,
                    child: Center(
                      child: Text(
                        actionBtnTxt ?? 'Delete',
                        style: TextStyle(
                          fontSize: 16.0,
                          color:  Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          Divider(
            height: disableActionBtn == false ? 1.2 : 0,
            color: Colors.white,
          ),
          disablePopupBtn == false
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15),
                    ),
                    highlightColor: Colors.grey[200],
                    onTap: () {
                      Navigator.of(context).pop('refresh');
                    },
                    child: Center(
                      child: Text(
                        popBtnText != null ? popBtnText ?? '' : 'Cancel',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
