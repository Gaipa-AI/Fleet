codeunit 50009 "Workflow_Approval"
{
    //*WorkflowApproval
    var WorkflowManagement: Codeunit "Workflow Management";
    UnsupportedRecordTypeErr: label 'Record type %1 is not supported by this workflow response.', Comment='Record type Customer is not supported by this workflow response.';
    NoWorkflowEnabledErr: label 'This record is not supported by related approval workflow.';
    OnSendItemConsumptionApprovalRequestTxt: label 'Approval of a Item Consumption is requested';
    RunWorkflowOnSendItemConsumptionForApprovalCode: label 'RUNWORKFLOWONSENDITEMCONSUMPTIONFORAPPROVAL';
    OnCancelItemConsumptionApprovalRequestTxt: label 'An Approval of a Item Consumption is canceled';
    RunWorkflowOnCancelItemConsumptionForApprovalCode: label 'RUNWORKFLOWONCANCELITEMCONSUMPTIONFORAPPROVAL';
    OnSendTransferOrderApprovalRequestTxt: label 'Approval of a Transfer Order is requested';
    RunWorkflowOnSendTransferOrderForApprovalCode: label 'RUNWORKFLOWONSENDTRANSFERORDERFORAPPROVAL';
     OnCanceTransferOrderApprovalRequestTxt: label 'An Approval of a TransferOrder is canceled';
     RunWorkflowOnCancelTransferOrderForApprovalCode: label 'RUNWORKFLOWONCANCELTRANSFERORDERFORAPPROVAL';
    
    OnSendMaterialRequestApprovalRequestTxt: label 'Approval of a Material Request is requested';
    RunWorkflowOnSendMaterialRequestForApprovalCode: label 'RUNWORKFLOWONSENDMATERIALREQUESTFORAPPROVAL';
    OnCancelMaterialRequestApprovalRequestTxt: label 'An Approval of a Material Request is canceled';
    RunWorkflowOnCancelMaterialRequestForApprovalCode: label 'RUNWORKFLOWONCANCELMATERIALREQUESTFORAPPROVAL';
    OnSendMaterialRequestConsolidatedApprovalRequestTxt: label 'Approval of a Material Request Consolidated is requested';
    RunWorkflowOnSendMaterialRequestConsolidatedForApprovalCode: label 'RUNWORKFLOWONSENDMATERIALREQUESTCONSOLIDATEDFORAPPROVAL';
    OnCancelMaterialRequestConsolidatedApprovalRequestTxt: label 'An Approval of a Material Request Consolidated is canceled';
    RunWorkflowOnCancelMaterialRequestConsolidatedForApprovalCode: label 'RUNWORKFLOWONCANCELMATERIALREQUESTCONSOLIDATEDFORAPPROVAL';
    OnSendPurchaseRequestApprovalRequestTxt: label 'Approval of a Purchase Request is requested';
    RunWorkflowOnSendPurchaseRequestForApprovalCode: label 'RUNWORKFLOWONSENDPURCHASEREQUESTFORAPPROVAL';
    OnCancelPurchaseRequestApprovalRequestTxt: label 'An Approval of a Purchase Request is canceled';
    RunWorkflowOnCancelPurchaseRequestForApprovalCode: label 'RUNWORKFLOWONCANCELPURCHASEREQUESTFORAPPROVAL';
    OnSendCashPurchaseApprovalRequestTxt: label 'Approval of a Cash Purchase is requested';
    RunWorkflowOnSendCashPurchaseForApprovalCode: label 'RUNWORKFLOWONSENDCASHPURCHASEFORAPPROVAL';
    OnCancelCashPurchaseApprovalRequestTxt: label 'An Approval of a Cash Purchase is canceled';
    RunWorkflowOnCancelCashPurchaseForApprovalCode: label 'RUNWORKFLOWONCANCELCASHPURCHASEFORAPPROVAL';
    OnSendStoreApprovalRequestTxt: label 'Approval of a Store is requested';
    RunWorkflowOnSendStoreForApprovalCode: label 'RUNWORKFLOWONSENDSTOREFORAPPROVAL';
    OnCancelStoreApprovalRequestTxt: label 'An Approval of a Store is canceled';
    RunWorkflowOnCancelStoreForApprovalCode: label 'RUNWORKFLOWONCANCELSTOREFORAPPROVAL';
    //[Scope('Extension')]
    procedure CheckApprovalsWorkflowEnabled(var Variant: Variant): Boolean var RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of Database::"Cash Purchase": exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendCashPurchaseForApprovalCode));
        
        
        else
            Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;
    procedure CheckApprovalsWorkflowEnabledCode(var Variant: Variant;
    CheckApprovalsWorkflowTxt: Text): Boolean begin
        begin
            if not WorkflowManagement.CanExecuteWorkflow(Variant, CheckApprovalsWorkflowTxt)then Error(NoWorkflowEnabledErr);
            exit(true);
        end;
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendDocForApproval(var Variant: Variant)begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelDocApprovalRequest(var Variant: Variant)begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddWorkflowEventsToLibrary()var WorkFlowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendCashPurchaseForApprovalCode, Database::"Cash Purchase", OnSendCashPurchaseApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelCashPurchaseForApprovalCode, Database::"Cash Purchase", OnCancelCashPurchaseApprovalRequestTxt, 0, false);
        
    end;
    local procedure RunWorkflowOnSendApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::Workflow_Approval, 'OnSendDocForApproval', '', false, false)]
    procedure RunWorkflowOnSendApprovalRequest(var Variant: Variant)var RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of Database::"Cash Purchase": WorkflowManagement.HandleEvent(RunWorkflowOnSendCashPurchaseForApprovalCode, Variant);
        else
            Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::Workflow_Approval, 'OnCancelDocApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelApprovalRequest(var Variant: Variant)var RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of 
        Database::"Cash Purchase": WorkflowManagement.HandleEvent(RunWorkflowOnCancelCashPurchaseForApprovalCode, Variant);
        
        
        else
            Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;
    procedure Reopen(var RecRef: RecordRef;
    Handled: Boolean)var 
    CashPurchase: Record "Cash Purchase";
    
  
    Variant: Variant;
    begin
        case RecRef.Number of 
        
       
        Database::"Cash Purchase": begin
            RecRef.SetTable(CashPurchase);
            CashPurchase.Validate(Status, CashPurchase.Status::Open);
            CashPurchase.Modify;
            Variant:=CashPurchase;
            Handled:=true;
        end
        else
            Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;
    // procedure Release(RecRef: RecordRef;
    // var Handled: Boolean)var 
    // CashPurchase: Record "Cash Purchase";
    
    // Transfer: Record "Transfer Header";
    // Variant: Variant;
    // begin
    //     Handled:=true;
    //     case RecRef.Number of 
       
    //     Database::"Cash Purchase": begin
    //         RecRef.SetTable(CashPurchase);
    //         CashPurchase.Validate(Status, CashPurchase.Status::Released);
    //         CashPurchase.Modify;
    //         Variant:=CashPurchase;
    //         Handled:=true;
    //     end;
        
    //     else
    //         Handled:=false;
    //         Error(UnsupportedRecordTypeErr, RecRef.Caption);
    //     end end;
    // procedure SetStatusToPending(RecRef: RecordRef;
    // var Variant: Variant;
    // IsHandled: Boolean)var 
    // CashPurchase: Record "Cash Purchase";
    
    // begin
    //     case RecRef.Number of
    //     Database::"Cash Purchase": begin
    //         RecRef.SetTable(CashPurchase);
    //         CashPurchase.Validate(Status, CashPurchase.Status::"Pending Approval");
    //         CashPurchase.Modify;
    //         Variant:=CashPurchase;
    //         IsHandled:=true;
    //     end;
      
    //     else
    //         Error(UnsupportedRecordTypeErr, RecRef.Caption);
    //     end;
    // end;
    procedure SetStatusToReject(RecRef: RecordRef)var 
    CashPurchase: Record "Cash Purchase";
   
    Variant: Variant;
    begin
        case RecRef.Number of 
        Database::"Cash Purchase": begin
            RecRef.SetTable(CashPurchase);
            CashPurchase.Validate(Status, CashPurchase.Status::Rejected);
            CashPurchase.Modify;
            Variant:=CashPurchase;
        end;
       
        end;
    end;
    //*WorkflowApprovalsMgtExt
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    procedure PopulateApprovalEntryArgument(RecRef: RecordRef;
    WorkflowStepInstance: Record "Workflow Step Instance";
    VAR ApprovalEntryArgument: Record "Approval Entry")var Customer: Record Customer;
    GenJournalBatch: Record "Gen. Journal Batch";
    GenJournalLine: Record "Gen. Journal Line";
    PurchaseHeader: Record "Purchase Header";
    SalesHeader: Record "Sales Header";
    IncomingDocument: Record "Incoming Document";
    ApprovalAmount: Decimal;
    ApprovalAmountLCY: Decimal;
 
    CashPurchase: Record "Cash Purchase";
    
    Transfer : Record "Transfer Header";
    //recent
    FormHeader: Record "Form Header";
    MainHeader: Record "Maintenance Header";
    ADTHeader: Record "ADT Requisition Header";
    begin
        ApprovalEntryArgument.INIT;
        ApprovalEntryArgument."Table ID":=RecRef.Number;
        ApprovalEntryArgument."Record ID to Approve":=RecRef.RECORDID;
        //ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
        ApprovalEntryArgument."Approval Code":=WorkflowStepInstance."Workflow Code";
        ApprovalEntryArgument."Workflow Step Instance ID":=WorkflowStepInstance.ID;
        case RecRef.Number of Database::"Purchase Header": begin
            RecRef.SetTable(PurchaseHeader);
            // CalcPurchaseDocAmount(PurchaseHeader,ApprovalAmount,ApprovalAmountLCY);
            ApprovalEntryArgument."Document Type":=PurchaseHeader."Document Type";
            ApprovalEntryArgument."Document No.":=PurchaseHeader."No.";
            ApprovalEntryArgument."Salespers./Purch. Code":=PurchaseHeader."Purchaser Code";
            ApprovalEntryArgument.Amount:=ApprovalAmount;
            ApprovalEntryArgument."Amount (LCY)":=ApprovalAmountLCY;
            ApprovalEntryArgument."Currency Code":=PurchaseHeader."Currency Code";
        end;
        Database::"Sales Header": begin
            RecRef.SetTable(SalesHeader);
            // CalcSalesDocAmount(SalesHeader,ApprovalAmount,ApprovalAmountLCY);
            ApprovalEntryArgument."Document Type":=SalesHeader."Document Type";
            ApprovalEntryArgument."Document No.":=SalesHeader."No.";
            ApprovalEntryArgument."Salespers./Purch. Code":=SalesHeader."Salesperson Code";
            ApprovalEntryArgument.Amount:=ApprovalAmount;
            ApprovalEntryArgument."Amount (LCY)":=ApprovalAmountLCY;
            ApprovalEntryArgument."Currency Code":=SalesHeader."Currency Code";
        //  ApprovalEntryArgument."Available Credit Limit (LCY)" := GetAvailableCreditLimit(SalesHeader);
        end;
        Database::Customer: begin
            RecRef.SetTable(Customer);
            ApprovalEntryArgument."Salespers./Purch. Code":=Customer."Salesperson Code";
            ApprovalEntryArgument."Currency Code":=Customer."Currency Code";
            ApprovalEntryArgument."Available Credit Limit (LCY)":=Customer.CalcAvailableCredit;
        end;
        Database::"Gen. Journal Batch": begin
            RecRef.SetTable(GenJournalBatch);
        end;
        Database::"Gen. Journal Line": begin
            RecRef.SetTable(GenJournalLine);
            ApprovalEntryArgument."Document Type":=GenJournalLine."Document Type";
            ApprovalEntryArgument."Document No.":=GenJournalLine."Document No.";
            ApprovalEntryArgument."Salespers./Purch. Code":=GenJournalLine."Salespers./Purch. Code";
            ApprovalEntryArgument.Amount:=GenJournalLine.Amount;
            ApprovalEntryArgument."Amount (LCY)":=GenJournalLine."Amount (LCY)";
            ApprovalEntryArgument."Currency Code":=GenJournalLine."Currency Code";
        end;
        Database::"Incoming Document": begin
            RecRef.SetTable(IncomingDocument);
            ApprovalEntryArgument."Document No.":=Format(IncomingDocument."Entry No.");
        end;
        Database::"Cash Purchase": begin
            RecRef.SetTable(CashPurchase);
            ApprovalEntryArgument."Document No.":=CashPurchase."No.";
        end;
        //recently added
        Database:: "Form Header": begin
            RecRef.SetTable(FormHeader);
            ApprovalEntryArgument."Document Type" := FormHeader."Document Type";
            ApprovalEntryArgument."Document No.":= FormHeader."No.";
            
        end;
        Database:: "Maintenance Header": begin
            RecRef.SetTable(MainHeader);
            ApprovalEntryArgument."Document Type" := MainHeader."Document Type";
            ApprovalEntryArgument."Document No.":= MainHeader."No.";
            
        end;
        Database:: "ADT Requisition Header": begin
            RecRef.SetTable(ADTHeader);
            ApprovalEntryArgument."Document Type" := ADTHeader."Document Type";
            ApprovalEntryArgument."Document No.":= ADTHeader."No.";
            
        end;
        else
            Error(UnsupportedRecordTypeErr, RecRef.Caption);
       
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeMakeApprovalEntry', '', false, false)]
    local procedure OnBeforeMakeApprovalEntry(var ApprovalEntry: Record "Approval Entry";
    ApprovalEntryArgument: Record "Approval Entry";
    WorkflowStepArgument: Record "Workflow Step Argument";
    ApproverId: Code[50];
    var IsHandled: Boolean);
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeDelegateApprovalRequests', '', false, false)]
    local procedure OnBeforeDelegateApprovalRequests(var ApprovalEntry: Record "Approval Entry";
    var IsHandled: Boolean);
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApproveSelectedApprovalRequest', '', false, false)]
    local procedure OnBeforeApproveSelectedApprovalRequest(var ApprovalEntry: Record "Approval Entry";
    var IsHandled: Boolean);
    begin
    end;
    //*WorkflowEventHandling
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef;
    var Handled: Boolean)var CustomApproval: Codeunit Workflow_Approval;
    begin
        CustomApproval.ReOpen(RecRef, true);
        Handled:=true;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef;
    var Handled: Boolean)var CustomApproval: Codeunit Workflow_Approval;
    begin
        //CustomApproval.Release(RecRef, Handled);
        Handled:=true;
    end;
    //statuspending
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef;
    var Variant: Variant;
    var iSHandled: Boolean)var CustomApproval: Codeunit Workflow_Approval;
    begin
        //CustomApproval.SetStatusToPending(RecRef, Variant, true);
        iSHandled:=true;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeRejectApprovalRequestsForRecord', '', false, false)]
    local procedure "Approvals Mgmt._OnBeforeRejectApprovalRequestsForRecord"(RecRef: RecordRef;
    WorkflowStepInstance: Record "Workflow Step Instance";
    var IsHandled: Boolean)var CustomApproval: Codeunit Workflow_Approval;
    begin
    //CustomApproval.SetStatusToReject(RecRef, true);
    //iSHandled := true;
    end;
    /*    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequestsForRecordOnAfterSetApprovalEntryFilters', '', false, false)]
       local procedure "Approvals Mgmt._OnRejectApprovalRequestsForRecordOnAfterSetApprovalEntryFilters"(var ApprovalEntry: Record "Approval Entry"; RecRef: RecordRef)
       var
           CustomApproval: Codeunit Workflow_Approval;
       begin
           Message('looks like');
           CustomApproval.SetStatusToReject(RecRef);
       end; */
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure "Approvals Mgmt._OnRejectApprovalRequest"(var ApprovalEntry: Record "Approval Entry")var 
    CashPurchase: Record "Cash Purchase";
   
    begin
        //Message('looks like');
        case ApprovalEntry."Table ID" of 
        50020: begin
            CashPurchase.Reset;
            CashPurchase.SetRange("No.", ApprovalEntry."Document No.");
            if CashPurchase.FindFirst then begin
                CashPurchase.Validate(Status, CashPurchase.Status::Rejected);
                CashPurchase.Modify;
            end;
        end;
        
        end;
    end;
}
