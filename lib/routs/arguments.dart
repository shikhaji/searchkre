class SendArguments {
  String? continueAs;
  String? mobileNumber;
  int? otpStatus;
  int? bottomIndex;
  String? kycLoginId;
  String? postId;
  bool? editPost;

  SendArguments(
      {this.continueAs,
      this.mobileNumber,
      this.otpStatus,
      this.editPost = false,
      this.postId,
      this.bottomIndex,
      this.kycLoginId});
}
