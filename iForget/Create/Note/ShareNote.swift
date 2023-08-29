/*
 import CloudKit
 import SwiftUI

 struct CloudSharingController: UIViewControllerRepresentable {
     let store: Note
     @Binding var isShowing: Bool

     func makeUIViewController(context: Context) -> CloudControllerHost {
         let host = CloudControllerHost()
         host.rootRecord = store.noteRecord
         host.container = store.container
         return host
     }

     func updateUIViewController(_ host: CloudControllerHost, context: Context) {
         if isShowing, host.isPresented == false {
             host.share()
         }
     }
 }


 final class CloudControllerHost: UIViewController {
     var rootRecord: CKRecord? = nil
     var container: CKContainer = .default()
     var isPresented = false

     func share() {
         let sharingController = shareController
         isPresented = true
         present(sharingController, animated: true, completion: nil)
     }

     lazy var shareController: UICloudSharingController = {
         let controller = UICloudSharingController { [weak self] controller, completion in
             guard let self = self else { return completion(nil, nil, CloudError.controllerInvalidated) }
             guard let record = self.rootRecord else { return completion(nil, nil, CloudError.missingNoteRecord) }

             let share = CKShare(rootRecord: record)
             let operation = CKModifyRecordsOperation(recordsToSave: [record, share], recordIDsToDelete: [])
             operation.modifyRecordsCompletionBlock = { saved, _, error in
                 if let error = error {
                     return completion(nil, nil, error)
                 }
                 completion(share, self.container, nil)
             }
             self.container.privateCloudDatabase.add(operation)
         }
         controller.delegate = self
         controller.popoverPresentationController?.sourceView = self.view
         return controller
     }()
 }

 */
