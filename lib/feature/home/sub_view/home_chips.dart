part of '../home_view.dart';

class _ActiveChip extends StatelessWidget {
  const _ActiveChip(this.tag);
  final Tag tag;
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(tag.name ?? '',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: ColorConstants.white)),
      backgroundColor: ColorConstants.purplePrimary,
      padding: const EdgeInsets.all(8),
    );
  }
}

class _PassiveChip extends StatelessWidget {
  const _PassiveChip(this.tag);
  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        tag.name ?? '',
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: ColorConstants.grayPrimary),
      ),
      backgroundColor: ColorConstants.grayLighter,
      padding: const EdgeInsets.all(8),
    );
  }
}
