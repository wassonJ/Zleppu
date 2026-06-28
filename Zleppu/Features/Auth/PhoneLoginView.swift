import SwiftUI

struct PhoneLoginView: View {
    @Environment(AuthState.self) private var auth

    @State private var step: LoginStep = .phone
    @State private var phoneInput = ""
    @State private var codeInput = ""
    @State private var errorMessage: String?

    private enum LoginStep {
        case phone
        case code
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ZleppuTheme.background.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        ZleppuLogo(size: 56)
                            .padding(.top, 24)

                        Text("Wake up together.\nStay consistent.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(ZleppuTheme.textSecondary)

                        VStack(spacing: 16) {
                            if step == .phone {
                                phoneStep
                            } else {
                                codeStep
                            }

                            if let errorMessage {
                                Text(errorMessage)
                                    .font(.footnote)
                                    .foregroundStyle(ZleppuTheme.danger)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(24)
                        .zleppuCard()

                        Button("Continue as guest instead") {
                            auth.loginAsGuest()
                        }
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(ZleppuTheme.slate)

                        Text("No public profile. Only people you trust.")
                            .font(.caption)
                            .foregroundStyle(ZleppuTheme.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        auth.showLogin = false
                    }
                }
            }
        }
    }

    private var phoneStep: some View {
        VStack(spacing: 16) {
            Text("Enter your phone number")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("+46 70 123 45 67", text: $phoneInput)
                .keyboardType(.phonePad)
                .textContentType(.telephoneNumber)
                .padding(16)
                .background(ZleppuTheme.background)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

            Button("Send code") {
                sendCode()
            }
            .buttonStyle(ZleppuPrimaryButtonStyle())
            .disabled(phoneInput.filter(\.isNumber).count < 8)
        }
    }

    private var codeStep: some View {
        VStack(spacing: 16) {
            Text("Enter verification code")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("We sent a code to \(formattedPhone)")
                .font(.subheadline)
                .foregroundStyle(ZleppuTheme.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("000000", text: $codeInput)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .multilineTextAlignment(.center)
                .font(.title2.monospacedDigit())
                .padding(16)
                .background(ZleppuTheme.background)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .onChange(of: codeInput) { _, newValue in
                    codeInput = String(newValue.filter(\.isNumber).prefix(6))
                }

            Button("Verify") {
                verifyCode()
            }
            .buttonStyle(ZleppuPrimaryButtonStyle())
            .disabled(codeInput.count != 6)

            Button("Change number") {
                step = .phone
                codeInput = ""
                errorMessage = nil
            }
            .font(.subheadline)
            .foregroundStyle(ZleppuTheme.slate)
        }
    }

    private var formattedPhone: String {
        phoneInput.isEmpty ? auth.phoneNumber : phoneInput
    }

    private func sendCode() {
        errorMessage = nil
        let digits = phoneInput.filter(\.isNumber)
        guard digits.count >= 8 else {
            errorMessage = "Enter a valid phone number."
            return
        }
        auth.phoneNumber = phoneInput
        step = .code
    }

    private func verifyCode() {
        errorMessage = nil
        if auth.verifyCode(codeInput) { return }
        errorMessage = "Invalid code. Try again."
    }
}

#Preview {
    PhoneLoginView()
        .environment(AuthState())
}
