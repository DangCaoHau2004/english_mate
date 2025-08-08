class AuthErrorConverter {
  static const Map<String, String> _authErrors = {
    "admin-restricted-operation": "Thao tác này chỉ dành cho quản trị viên.",
    "argument-error": "Đã xảy ra lỗi về đối số. Vui lòng thử lại.",
    "app-not-authorized":
        "Ứng dụng này chưa được ủy quyền. Vui lòng kiểm tra cấu hình API của bạn.",
    "app-not-installed":
        "Ứng dụng di động không được cài đặt trên thiết bị này.",
    "captcha-check-failed":
        "Mã xác nhận không hợp lệ hoặc đã hết hạn. Vui lòng thử lại.",
    "code-expired": "Mã SMS đã hết hạn. Vui lòng gửi lại mã xác minh.",
    "cordova-not-ready": "Khung Cordova chưa sẵn sàng.",
    "cors-unsupported": "Trình duyệt này không được hỗ trợ.",
    "credential-already-in-use":
        "Thông tin đăng nhập này đã được liên kết với một tài khoản người dùng khác.",
    "custom-token-mismatch": "Mã thông báo tùy chỉnh không khớp.",
    "requires-recent-login":
        "Thao tác này nhạy cảm và yêu cầu đăng nhập lại gần đây. Vui lòng đăng nhập lại.",
    "dynamic-link-not-activated":
        "Vui lòng kích hoạt Dynamic Links trong Firebase Console.",
    "email-change-needs-verification":
        "Người dùng đa yếu tố phải luôn có email đã xác minh.",
    "email-already-in-use":
        "Địa chỉ email này đã được sử dụng bởi một tài khoản khác.",
    "expired-action-code": "Mã hành động đã hết hạn. ",
    "cancelled-popup-request":
        "Thao tác này đã bị hủy do một cửa sổ bật lên khác đã được mở.",
    "internal-error": "Đã xảy ra lỗi nội bộ. Vui lòng thử lại sau.",
    "invalid-app-credential": "Thông tin xác minh ứng dụng không hợp lệ.",
    "invalid-app-id":
        "Mã định danh ứng dụng di động không được đăng ký cho dự án hiện tại.",
    "invalid-user-token":
        "Thông tin xác thực của người dùng không hợp lệ cho dự án này.",
    "invalid-auth-event": "Đã xảy ra lỗi nội bộ.",
    "invalid-verification-code":
        "Mã xác minh SMS không hợp lệ. Vui lòng gửi lại.",
    "invalid-continue-uri": "URL tiếp tục được cung cấp không hợp lệ.",
    "invalid-cordova-configuration":
        "Cần cài đặt các plugin Cordova để bật đăng nhập OAuth.",
    "invalid-custom-token": "Định dạng mã thông báo tùy chỉnh không đúng.",
    "invalid-dynamic-link-domain":
        "Miền dynamic link được cung cấp không được cấu hình hoặc ủy quyền.",
    "invalid-email": "Địa chỉ email không đúng định dạng.",
    "invalid-api-key": "Khóa API của bạn không hợp lệ. Vui lòng kiểm tra lại.",
    "invalid-cert-hash": "Giá trị hash của chứng chỉ SHA-1 không hợp lệ.",
    "invalid-credential":
        "Thông tin xác thực được cung cấp bị lỗi hoặc đã hết hạn.",
    "invalid-message-payload": "Mẫu email chứa các ký tự không hợp lệ.",
    "invalid-multi-factor-session":
        "Yêu cầu không chứa bằng chứng hợp lệ về việc đăng nhập yếu tố đầu tiên thành công.",
    "invalid-oauth-provider":
        "EmailAuthProvider không được hỗ trợ cho thao tác này.",
    "invalid-oauth-client-id":
        "ID máy khách OAuth không hợp lệ hoặc không khớp với khóa API.",
    "unauthorized-domain":
        "Miền này không được ủy quyền cho các hoạt động OAuth cho dự án Firebase của bạn.",
    "invalid-action-code":
        "Mã hành động không hợp lệ. Mã có thể bị lỗi, hết hạn hoặc đã được sử dụng.",
    "wrong-password":
        "Mật khẩu không hợp lệ hoặc người dùng không có mật khẩu.",
    "invalid-persistence-type": "Kiểu lưu trữ được chỉ định không hợp lệ.",
    "invalid-phone-number":
        "Định dạng số điện thoại không đúng. Vui lòng nhập định dạng E.164.",
    "invalid-provider-id": "ID nhà cung cấp được chỉ định không hợp lệ.",
    "invalid-recipient-email": "Email người nhận không hợp lệ.",
    "invalid-sender":
        "Mẫu email chứa địa chỉ người gửi hoặc tên người gửi không hợp lệ.",
    "invalid-verification-id":
        "ID xác minh được sử dụng để tạo thông tin xác thực điện thoại không hợp lệ.",
    "invalid-tenant-id": "ID khách của phiên bản Auth không hợp lệ.",
    "multi-factor-info-not-found":
        "Người dùng không có yếu tố thứ hai phù hợp với mã định danh được cung cấp.",
    "multi-factor-auth-required":
        "Cần có bằng chứng sở hữu yếu tố thứ hai để hoàn tất đăng nhập.",
    "missing-android-pkg-name": "Tên gói Android phải được cung cấp.",
    "auth-domain-config-required":
        "Hãy đảm bảo bao gồm authDomain khi gọi firebase.initializeApp().",
    "missing-app-credential":
        "Yêu cầu xác minh điện thoại thiếu xác nhận trình xác minh ứng dụng.",
    "missing-verification-code":
        "Thông tin xác thực điện thoại được tạo với mã xác minh SMS trống.",
    "missing-continue-uri": "URL tiếp tục phải được cung cấp trong yêu cầu.",
    "missing-iframe-start": "Đã xảy ra lỗi nội bộ.",
    "missing-ios-bundle-id": "ID gói iOS phải được cung cấp.",
    "missing-multi-factor-info":
        "Không có mã định danh yếu tố thứ hai được cung cấp.",
    "missing-multi-factor-session":
        "Yêu cầu thiếu bằng chứng về việc đăng nhập yếu tố đầu tiên thành công.",
    "missing-or-invalid-nonce": "Yêu cầu không chứa một nonce hợp lệ.",
    "missing-phone-number":
        "Để gửi mã xác minh, vui lòng cung cấp số điện thoại người nhận.",
    "missing-verification-id":
        "Thông tin xác thực điện thoại được tạo với ID xác minh trống.",
    "app-deleted": "Phiên bản FirebaseApp này đã bị xóa.",
    "account-exists-with-different-credential":
        "Một tài khoản đã tồn tại với cùng địa chỉ email nhưng bằng thông tin đăng nhập khác. Vui lòng đăng nhập bằng nhà cung cấp liên kết với email này.",
    "network-request-failed":
        "Đã xảy ra lỗi mạng. Vui lòng kiểm tra kết nối của bạn.",
    "no-auth-event": "Đã xảy ra lỗi nội bộ.",
    "no-such-provider":
        "Người dùng không được liên kết với tài khoản bằng nhà cung cấp đã cho.",
    "null-user": "Đã cung cấp đối tượng người dùng rỗng.",
    "operation-not-allowed":
        "Nhà cung cấp đăng nhập này bị vô hiệu hóa cho dự án Firebase của bạn. Vui lòng bật nó trong Firebase console.",
    "operation-not-supported-in-this-environment":
        "Thao tác này không được hỗ trợ trong môi trường ứng dụng này đang chạy.",
    "popup-blocked":
        "Không thể thiết lập kết nối với cửa sổ bật lên. Nó có thể đã bị trình duyệt chặn.",
    "popup-closed-by-user":
        "Cửa sổ bật lên đã bị người dùng đóng trước khi hoàn tất thao tác.",
    "provider-already-linked":
        "Người dùng chỉ có thể được liên kết với một danh tính cho nhà cung cấp đã cho.",
    "quota-exceeded": "Hạn mức của dự án cho thao tác này đã bị vượt quá.",
    "redirect-cancelled-by-user":
        "Thao tác chuyển hướng đã bị người dùng hủy trước khi hoàn tất.",
    "redirect-operation-pending":
        "Đang có một thao tác đăng nhập chuyển hướng đang chờ xử lý.",
    "rejected-credential":
        "Yêu cầu chứa thông tin xác thực bị lỗi hoặc không khớp.",
    "second-factor-already-in-use":
        "Yếu tố thứ hai đã được đăng ký trên tài khoản này.",
    "maximum-second-factor-count-exceeded":
        "Số lượng yếu tố thứ hai tối đa cho phép trên một người dùng đã bị vượt quá.",
    "tenant-id-mismatch":
        "ID khách được cung cấp không khớp với ID khách của phiên bản Auth.",
    "timeout": "Thao tác đã hết thời gian chờ.",
    "user-token-expired":
        "Thông tin xác thực của người dùng không còn hợp lệ. Người dùng phải đăng nhập lại.",
    "too-many-requests":
        "Chúng tôi đã chặn tất cả các yêu cầu từ thiết bị này do hoạt động bất thường. Vui lòng thử lại sau.",
    "unauthorized-continue-uri":
        "Miền của URL tiếp tục không được đưa vào danh sách trắng.",
    "unsupported-first-factor":
        "Đăng ký yếu tố thứ hai hoặc đăng nhập bằng tài khoản đa yếu tố yêu cầu đăng nhập bằng yếu tố đầu tiên được hỗ trợ.",
    "unsupported-persistence-type":
        "Môi trường hiện tại không hỗ trợ kiểu lưu trữ được chỉ định.",
    "unsupported-tenant-operation":
        "Thao tác này không được hỗ trợ trong ngữ cảnh đa đối tượng thuê.",
    "unverified-email": "Thao tác yêu cầu một email đã được xác minh.",
    "user-cancelled": "Người dùng không cấp quyền cho ứng dụng của bạn.",
    "user-not-found":
        "Không có bản ghi người dùng tương ứng với mã định danh này. Người dùng có thể đã bị xóa.",
    "user-disabled": "Tài khoản người dùng đã bị quản trị viên vô hiệu hóa.",
    "user-mismatch":
        "Thông tin xác thực được cung cấp không tương ứng với người dùng đã đăng nhập trước đó.",
    "user-signed-out": "Người dùng đã đăng xuất.",
    "weak-password": "Mật khẩu phải có ít nhất 6 ký tự.",
    "web-storage-unsupported":
        "Trình duyệt này không được hỗ trợ hoặc cookie của bên thứ 3 và dữ liệu có thể bị tắt.",
  };

  static String getErrorMessage(String errorCode) {
    return _authErrors[errorCode] ??
        "Đã xảy ra lỗi không xác định. Vui lòng thử lại.";
  }
}
