//
//  About.swift
//  iForget
//
//  Created by Vinícius Lopes on 24/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct About: View {
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                TermsOfUse()
                PrivacyPolity()
                    .padding(.top, 35)
                
            }
            
        }.navigationBarTitle("About", displayMode: .inline)
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}

struct TermsOfUse: View {
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("Terms of Use")
                    .font(.system(size: 27, weight: .heavy))
                    .padding(.top)
                Group{
                    Text("Last updated: August 3, 2020")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                    Text("""
                    These Terms of Service (“Terms”, “Terms of Service”, “Agreement”, or “Service Agreement”) govern your relationship with the iForget Service (the “Service”) operated by Vinyl, Inc. (“us”, “we”, or “our”). It is important that you read this carefully because you will be legally bound to these terms.
                    Your access to and use of the Service is based on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users, customers, and others who access or use the Service.
                    By accessing or using the Service you agree to be bound by these Terms and accept all legal consequences. If you do not agree to the terms and conditions of this Agreement, in whole or in part, please do not use the Service.
                    """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Description of Service")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("The “Service” comprehend (i) Vinyl, Inc.’s password managing, document storing, administrative and related systems and technologies, and (ii) all software, applications, data, text, images, and other content made available by or on behalf of Vinyl, Inc. Any modifications of the Service are also subject to these Terms. Vinyl Inc. reserves the right to modify or discontinue the Service or any feature or functionality thereof at any time without notice. All rights, title and interest in and to the Service will remain with and belong exclusively to Vinyl, Inc.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Subscriptions")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("""
                        Some parts of the Service are billed on a subscription basis (“Subscription(s)"). You will be billed in advance on a recurring and periodic basis (“Billing Cycle”). Billing cycles are set on a regular basis, typically monthly or yearly.
                    At the end of each Billing Cycle, your Subscription will automatically renew under the same conditions unless you cancel it or Vinyl, Inc. cancels it. You may cancel your Subscription renewal either through the settings available on Iforget or by contacting Vinyl, Inc. customer support team.
                    A valid payment method, including credit card, is required to process the payment for your Subscription. All payments are processed by Apple Pay and you should provide accurate and complete information as requested. By submitting such payment information, you automatically authorize Vinyl, Inc. to charge all Subscription fees incurred through your account to any such payment instruments. All amounts paid are non-refundable. You further agree to be responsible for all taxes associated with the Service, along with any transaction fees and currency conversions added by your financial institution and intermediaries. All amounts are in US Dollars.
                    """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Free Trial")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("""
                        Vinyl, Inc. may, at its sole discretion, offer a Subscription with a free trial for a limited period of time (“Free Trial”).
                        You may be required to enter your billing information in order to sign up for the Free Trial.
                        If you do enter your billing information when signing up for the Free Trial, you will not be charged by Vinyl, Inc. until the Free Trial has expired. On the last day of the Free Trial period, unless you cancelled your Subscription, you will be automatically charged the applicable Subscription fees for the type of Subscription you have selected.
                        At any time and without notice, Vinyl, Inc. reserves the right to (i) modify the terms and conditions of the Free Trial offer, or (ii) cancel such Free Trial offer.
                        """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Fee Changes")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("""
                        Vinyl, Inc., in its sole discretion and at any time, may modify the Subscription fees for the Subscriptions. Any Subscription fee change will become effective at the end of the then-current Billing Cycle.
                        Vinyl, Inc. will provide you with reasonable prior notice of any change in Subscription fees to give you an opportunity to terminate your Subscription before such change becomes effective.
                        Your continued use of the Service after the Subscription fee change comes into effect constitutes your agreement to pay the modified Subscription fee amount.
                        """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                
            }
            .padding(.horizontal)
            VStack(alignment: .leading) {
                Group{
                    Text("Refunds")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("While all amounts paid are non-refundable, certain refund requests for Subscriptions may be considered by Vinyl, Inc. on a case-by-case basis and granted at the sole discretion of Vinyl, Inc.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Log in password")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("""
                        You are responsible for safeguarding the password that you use to access the Service and for any activities or actions under your password.
                        You agree not to disclose your password to any third party. You must notify us immediately upon becoming aware of any breach of security or unauthorized use of your account.
                        """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Intellectual Property")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("The Service and all contents, including but not limited to text, images, graphics or code are the property of Vinyl, Inc. and are protected by copyright, trademarks, database and other intellectual property rights. You may display and copy, download or print portions of the material from the different areas of the Service only for your own non-commercial use. Any other use is strictly prohibited and may violate copyright, trademark and other laws. These Terms do not grant you a license to use any trademark of Vinyl, Inc.. You further agree not to use, change or delete any proprietary notices from materials downloaded from the Service.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("User-Generated Content")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("Your Data” means any data and content which you upload, store, retrieve, or otherwise make available through the Service. You retain all of the rights to Your Data. You agree to grant Vinyl, Inc. a license to store, retrieve, backup, restore, and otherwise copy Your Data so that we may provide you with the Service.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Links To Other Web Sites")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("""
                        The Service may contain links to third-party web sites or services that are not owned or controlled by Vinyl, Inc..
                        Vinyl, Inc. has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third party web sites or services. You further acknowledge and agree that Vinyl, Inc. shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any such content, goods or services available on or through any such websites or services.
                        We strongly advise you to read the terms and conditions and privacy policies of any third-party web sites or services that you visit.
                        """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Billing Emails")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("The Service will not send any operational emails. Billing emails are the sole responsibility of Apple Pay.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Termination")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("""
                        You are entitled to cease using our Services at any time and for any reason without notice to us, but you will continue to be charged for Services until you cancel your account by accessing iForget definitions or contacting us.
                        Our duty is to keep our Service as safe and well maintained as possible. To this end, we may need to terminate accounts for violations of these Terms. We will not provide any notice regarding the termination of your account because the discretion of our service doesn’t allow us to send you notifications of any kind. In the event of such a termination we will work with you to ensure you retain copies of your data, wherever permitted by law.
                        All provisions of the Terms shall survive termination. Upon termination, your right to use the Service will immediately cease.
                        """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Cookies and Tracking")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("We will comply with applicable laws to provide service data and encrypted secure data to law enforcement agencies. If permitted, we will notify you of such a request and whether or not we have complied. Your secure data remains encrypted with keys which we do not possess, and so we can only hand over secure data in encrypted form.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Limitation Of Liability")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("""
                        Vinyl, Inc., its directors, employees, partners, agents, suppliers, or affiliates, shall not be liable for (A) any loss or damage, indirect, incidental, special, consequential or punitive damages, including without limitation, economic loss, loss or damage to electronic media or data, goodwill, or other intangible losses, or (B) for any amount in the aggregate in excess of the fees actually paid by you in the six (6) months preceding the event giving rise to your claim, resulting from (i) your access to or use of the Service; (ii) your inability to access or use the Service; (iii) any conduct or content of any third-party on or related to the Service; (iv) any content obtained from or through the Service; and (v) the unauthorized access to, use of or alteration of your transmissions or content, whether based on warranty, contract, tort (including negligence) or any other claim in law, whether or not we have been informed of the possibility of such damage, and even if a remedy set forth herein is found to have failed of its essential purpose.
                        """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Disclaimer And Non-Waiver of Rights")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("""
                        Vinyl, Inc. makes no guarantees, representations or warranties of any kind. Any purportedly applicable warranties, terms and conditions are excluded, to the fullest extent permitted by law. Your use of the Service is at your sole risk.
                        The Service is provided on an “AS IS” and “AS AVAILABLE” basis. The Service is provided without warranties of any kind, whether express or implied, including, but not limited to, implied warranties of merchantability, fitness for a particular purpose, non-infringement or course of performance.
                        Vinyl, Inc. do not warrant that a) the Service will function uninterrupted, secure or available at any particular time or location; b) any errors or defects will be corrected; c) the Service is free of viruses or other harmful components; or d) the results of using the Service will meet your requirements.
                        If you breach any of these Terms and Vinyl, Inc. chooses not to immediately act, or chooses not to act at all, Vinyl, Inc. will still be entitled to all rights and remedies at any later date, or in any other situation, where you breach these Terms. Vinyl, Inc. does not waive any of its rights. Vinyl, Inc. shall not be responsible for any purported breach of these Terms caused by circumstances beyond its control. A person who is not a party to these Terms shall have no rights of enforcement.
                        You may not assign, sub-license or otherwise transfer any of your rights under these Terms.
                        """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
            }
            .padding(.horizontal)
            VStack(alignment: .leading) {
                Group{
                    Text("Exclusions")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("""
                        As set out, above, some jurisdictions do not allow the exclusion of certain warranties or the exclusion or limitation of liability for consequential or incidental damages, so the limitations above may not apply to you.
                        """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Governing Law")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("""
                        These Terms shall be governed by, and interpreted and enforced in accordance with, the laws of Portugal, as applicable.
                        If any provision of these Terms is held to be invalid or unenforceable by a court of competent jurisdiction, then any remaining provisions of these Terms will remain in effect. These Terms constitute the entire agreement between us regarding our Service, and supersede and replace any prior agreements, oral or otherwise, regarding the Service.
                        """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Dispute Resolution")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("""
                        All disputes and questions whatsoever which shall arise between Vinyl, Inc. and you in connection with this Service Agreement, or the construction or application thereof or any provision contained in this Service Agreement or as to any act, deed or omission of any party or as to any other matter in any way relating to this Service Agreement, shall be resolved by arbitration. Such arbitration shall be conducted by a single arbitrator.
                        The arbitrator shall be appointed by agreement between the parties or, in default of such agreement, such arbitrator shall be appointed by the CICAP - Consumer Information and Arbitration Centre of Porto.
                        Unless otherwise agreed to by the parties, arbitration shall be held in the city of Porto, Portugal. The procedure to be followed shall be agreed to by the parties or, in default of such agreement, determined by the arbitrator. The arbitrator shall have the power to proceed with the arbitration and to deliver his or her award notwithstanding the default by any party in respect of any procedural order made by the arbitrator.
                        The decision arrived at by the arbitrator shall be final and binding and no appeal shall lie therefrom. Judgment upon the award rendered by the arbitrator may be entered in any court having jurisdiction.
                        """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Changes")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("""
                                       We reserve the right, at our sole discretion, to modify or replace these Terms at any time. By continuing to access or use our Service after those revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, in whole or in part, please stop using the Service.
                                       """)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                
            }.padding(.horizontal)
            VStack(alignment: .leading) {
                Group{
                    Text("Contact Us")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("If you have any questions about these Terms, you can contact us by email:")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                    Text("vinyl.contact.inc@gmail.com")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Text("Or write us by mail at:")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                        .padding(.top, 5)
                    Text("Passeio de São Lázaro, 43.")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Text("4000-508 Porto, Portugal.")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                }
            }.padding(.horizontal)
        }
    }
}

struct PrivacyPolity: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Text("Privacy Policy")
                    .font(.system(size: 27, weight: .heavy))
                    .padding(.top)
                Group{
                    Text("Last updated: July 25, 2020")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                    Text("We believe in the importance of privacy. The following privacy policy describes the personal data that Vinyl, Inc. collects and processes, as well as how we do it and for which purpose, while you use iForget products and services. This privacy policy also emphasizes our commitment to preserving the privacy and security of your personal data. ")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Brief overview of our commitment to privacy")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("At Vinyl, Inc. we believe that privacy is only real if we don’t get access to your personal data whatsoever. After all, it is impossible to lose, misuse, or abuse information we don’t have. Therefore we don’t require a registration to use our services and we use encryption software for all your data.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Who We Are")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("Vinyl, Inc is a Portuguese company located at Passeio de São Lázaro, 43, Porto, Portugal, 4000-508. Vinyl, Inc. complies with Portuguese privacy laws. We are fully compliant with the GDPR (General Data Protection Regulation) and Law no 58/2019 of 8 August, ensuring the execution of GDPR in Portugal.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Who are You")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("Unless otherwise noted, we refer you, the Customer, as an owner of an individual account.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Personal Data We Collect and How We Use your Personal Data")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("We do not collect or obtain data from third parties. We collect some data from you, in order to provide you with our iForget products and associated services. If you contact us for support, the data we collect is limited to your email address only. We get some limited data from your use of the iForget products and services (service data) such as the make and model of your device through which you access or use iForget products or services.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                    Text("However, there are data – secure data - that we are not capable of decrypting under any circumstance. It includes all information stored within vaults in iForget accounts. iForget secures your information by encrypting it when it's in transit, storing it in iCloud in an encrypted format, and using secure tokens for authentication. For certain sensitive information, iForget uses end-to-end encryption. This means that only you can access your information, and only on devices where you’re signed into iCloud. No one else, not even Apple or iForget, can access end-to-end encrypted information.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                    Text("Furthermore, there are diagnostic data, which are optional and are not automatically collected or required for operation of our services. In some cases we seek diagnostic reports and other troubleshooting, bug, and crash reports from customers to help identify and solve problems with our products and services. This information is sent to us only on a case by case basis, or by users who explicitly choose to provide diagnostic data to us. Diagnostic data may contain sensitive information about your devices and operating environment as well as personally identifying information. Although there may be occasions when we ask for diagnostic data to assist you with a problem, you are never obligated to provide it. Diagnostic data never includes decrypted secure data. We will never ask for your password.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                    Text("All the collected and processed data is treated securely with respect for customer privacy and data confidentiality.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                
            }
            .padding(.horizontal)
            VStack(alignment: .leading) {
                Group{
                    Text("Costumer support system")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("Our customer support and email services are hosted in Portugal. We may use your contact information, that is, the contact email address provided by you, to communicate with you in order to provide support. Due to the nature of our design and the sensitivity of the information you entrust to us (even in encrypted form), it may not be possible for us to help you with certain customer service requests.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Your Responsibilities for Protecting Your Data")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("When you create a password it must be strong and unique for your protection and ensure that is not easily guessed.It is extremely important that you understand that anyone with both your apple account logged in a device and your iForget password can access your data. We will never ask you for your password and you should never send it to us or anyone")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Data portability")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("You may export your iForget data at any time you wish during the time you use our service. To do that you have to be logged in your apple account and know your iForget password.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Your right to know what we know")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("You have the right to know what we know about you and to see how that data is handled. You may request a screenshot of what we can see about you in our back office systems. However, to protect customer privacy, such requests must be carefully authenticated.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Your right to access and control your personal data")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("You can control your personal data and exercise your data protection rights by contacting Vinyl, Inc at the address provided below (“contact us”) . You can add, remove, edit, change any data that are in the iForget vaults.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Your right to access and control your personal data")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("You can control your personal data and exercise your data protection rights by contacting Vinyl, Inc at the address provided below (“contact us”) . You can add, remove, edit, change any data that are in the iForget vaults.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Disclosure")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("We do not engage in or support cross-service tracking. Neither do we set or use cookies on our domains.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Cookies and Tracking")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("We will comply with applicable laws to provide service data and encrypted secure data to law enforcement agencies. If permitted, we will notify you of such a request and whether or not we have complied. Your secure data remains encrypted with keys which we do not possess, and so we can only hand over secure data in encrypted form.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Breach Notification")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("In an event of a breach, we recognize our responsibility to our customers and to the public to disclose the nature of the risk and provide a transparent account of the events without undue delay. We follow applicable requirements under the laws, that is, the requirements related to data breach notification under the GDPR.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
                Group{
                    Text("Updates to our Privacy Policy")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("At our discretion, we may make changes to this Policy and note the date of the last revision. You should check here frequently if you need to know of updates to our Privacy Policy. Previous versions will be made available from this page.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
            }
            .padding(.horizontal)
            VStack(alignment: .leading) {
                Group{
                    Text("Contact Us")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("If you have any questions about this Policy, you can contact us by email:")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                    Text("vinyl.contact.inc@gmail.com")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Text("Or write us by mail at:")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                        .padding(.top, 5)
                    Text("Passeio de São Lázaro, 43.")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Text("4000-508 Porto, Portugal.")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                }
                Group{
                    Text("Supervisory Authority")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                        .padding(.top, 20)
                    Text("If you have concerns or complaints about this policy or practices with regard to that you do not feel you can resolve through contacting us, you should bring those concerns to your local regulatory authority. For residents of the European Union, our primary Supervisory Authority is the Berlin Commissioner for Data Protection and Information Freedom")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                    Text("Berliner Beauftragte für Datenschutz und Informationsfreiheit")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                        .padding(.top)
                    Text("Friedrichstr. 219")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Text("10969 Berlin, Germany")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Text("Tel: +49 30 13889-0")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                        .padding(.top, 5)
                    Text("Fax: +49 30 2155050")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Text("E-Mail: mailbox@datenschutz-berlin.de")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Text("https://www.datenschutz-berlin.de")
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                }
            }.padding(.horizontal)
            
            HStack(alignment: .center){
                Spacer()
                Text("© 2020 iForget. All rights reserved.")
                    .font(.system(size: 12))
                    .opacity(0.2)
                Spacer()
            }
            .padding(.top, 35)
            .padding(.bottom, 35)
            
        }
    }
}


