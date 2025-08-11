
class CLassInfoState {}

class InitState extends CLassInfoState {}

class LoadingState extends CLassInfoState {}

class GetClassImage extends CLassInfoState {
  late String imagePath;
  GetClassImage({required this.imagePath});
}
