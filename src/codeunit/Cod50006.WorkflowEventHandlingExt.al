// /// <summary>
// /// Codeunit Workflow Event Handling Ext (ID 50004).
// /// </summary>
// codeunit 50006 "Workflow EventHandling Ext"
// {
//     Permissions = tabledata "ADT Requisition Header" = rim,
//     tabledata "Employee Statistics Group" = rimd,
//     tabledata Confidential = rimd,
//     tabledata "Res. Ledger Entry" = rim;

//     trigger OnRun()
//     begin

//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
//     local procedure OnAddWorkflowEventsToLibraryPRQ()
//     begin
//         WorkflowEventHandlingPRQ.AddEventToLibrary(RunWorkflowOnSendClaimForApprovalCodePRQ(), Database::"ADT Requisition Header", ClaimSendForApprovalEventDescTxtPRQ, 0, false);
//         WorkflowEventHandlingPRQ.AddEventToLibrary(RunWorkflowOnCancelClaimApprovalCodePRQ(), Database::"ADT Requisition Header", ClaimApprovalRequestCancelEventDescTxtPRQ, 0, false);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
//     local procedure OnAddWorkflowEventPredecessorsToLibraryPRQ(EventFunctionName: Code[128])
//     begin
//         case EventFunctionName of
//             RunWorkflowOnCancelClaimApprovalCodePRQ:
//                 WorkflowEventHandlingPRQ.AddEventPredecessor(RunWorkflowOnCancelClaimApprovalCodePRQ, RunWorkflowOnSendClaimForApprovalCodePRQ);
//             WorkflowEventHandlingPRQ.RunWorkflowOnApproveApprovalRequestCode:
//                 WorkflowEventHandlingPRQ.AddEventPredecessor(WorkflowEventHandlingPRQ.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendClaimForApprovalCodePRQ);
//         end;
//     end;

//     /// <summary>
//     /// RunWorkflowOnSendClaimForApprovalCode.
//     /// </summary>
//     /// <returns>Return value of type Code[128].</returns>
//     procedure RunWorkflowOnSendClaimForApprovalCodePRQ(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnSendClaimForApproval'))
//     end;

//     /// <summary>
//     /// RunWorkflowOnSendClaimForApproval.
//     /// </summary>
//     /// <param name="Claim">VAR Record "".</param>
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnSendClaimForApprovalPRQ', '', true, true)]
//     procedure RunWorkflowOnSendClaimForApprovalPRQ(var Claim: Record "ADT Requisition Header")
//     begin
//         workflowManagementPRQ.HandleEvent(RunWorkflowOnSendClaimForApprovalCodePRQ, Claim);
//     end;

//     /// <summary>
//     /// RunWorkflowOnCancelClaimApprovalCode.
//     /// </summary>
//     /// <returns>Return value of type Code[128].</returns>
//     procedure RunWorkflowOnCancelClaimApprovalCodePRQ(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelClaimApproval'))
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnCancelClaimForApprovalPRQ', '', true, true)]
//     local procedure RunWorkflowOnCancelClaimApprovalPRQ(var Claim: Record "ADT Requisition Header")
//     begin
//         workflowManagementPRQ.HandleEvent(RunWorkflowOnCancelClaimApprovalCodePRQ, Claim);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]
//     local procedure OnAddWorkflowCategoriesToLibraryPRQ()
//     begin
//         WorkflowSetupPRQ.InsertWorkflowCategory(ClaimWorkflowCategoryTxtPRQ, ClaimWorkflowCategoryDescTxtPRQ);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', true, true)]
//     local procedure OnAfterInsertApprovalsTableRelationsPRQ()
//     var
//         ApprovalEntry: Record 454;
//     begin
//         WorkflowSetupPRQ.InsertTableRelation(Database::"ADT Requisition Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]
//     local procedure OnInsertWorkflowTemplatesPRQ()
//     begin
//         InsertClaimApprovalWorkflowTemplatePRQ();
//     end;

//     local procedure InsertClaimApprovalWorkflowTemplatePRQ()
//     var
//         Workflow: Record 1501;
//     begin
//         WorkflowSetupPRQ.InsertWorkflowTemplate(Workflow, ClaimApprovalWorkflowCodeTxtPRQ, ClaimApprovalWorkfowDescTxtPRQ, ClaimWorkflowCategoryTxtPRQ);
//         InsertClaimApprovalWorkflowDetailsPRQ(Workflow);
//         WorkflowSetupPRQ.MarkWorkflowAsTemplate(Workflow);
//     end;

//     local procedure InsertClaimApprovalWorkflowDetailsPRQ(var Workflow: Record 1501)
//     var
//         WorkflowStepArgument: Record 1523;
//         BlankDateFormula: DateFormula;
//         WorkflowResponseHandling: Codeunit 1521;
//         Claim: Record "ADT Requisition Header";
//     begin
//         WorkflowSetupPRQ.InitWorkflowStepArgument(WorkflowStepArgument,
//         WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
//         0, '', BlankDateFormula, true);

//         WorkflowSetupPRQ.InsertDocApprovalWorkflowSteps(
//             Workflow,
//             BuildClaimTypeConditionsPRQ(Claim.Status::Open),
//             RunWorkflowOnSendClaimForApprovalCodePRQ,
//             BuildClaimTypeConditionsPRQ(Claim.Status::"Pending approval"),
//             RunWorkflowOnCancelClaimApprovalCodePRQ,
//             WorkflowStepArgument,
//             true);
//     end;

//     local procedure BuildClaimTypeConditionsPRQ(Status: Integer): Text
//     var
//         Claim: Record "ADT Requisition Header";
//     begin
//         Claim.SetRange(Claim.Status, Status);
//         exit(StrSubstNo(ClaimTypeCondTxtPRQ, WorkflowSetupPRQ.Encode(Claim.GetView(false))))
//     end;

//     // Workflow Event Handling for Maintenance Request====================
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
//     local procedure OnAddWorkflowEventsToLibraryMR()
//     begin
//         WorkflowEventHandlingMR.AddEventToLibrary(RunWorkflowOnSendClaimForApprovalCodeMR(), Database::"Maintenance Header", ClaimSendForApprovalEventDescTxtMR, 0, false);
//         WorkflowEventHandlingMR.AddEventToLibrary(RunWorkflowOnCancelClaimApprovalCodeMR(), Database::"Maintenance Header", ClaimApprovalRequestCancelEventDescTxtMR, 0, false);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
//     local procedure OnAddWorkflowEventPredecessorsToLibraryMR(EventFunctionName: Code[128])
//     begin
//         case EventFunctionName of
//             RunWorkflowOnCancelClaimApprovalCodeMR:
//                 WorkflowEventHandlingMR.AddEventPredecessor(RunWorkflowOnCancelClaimApprovalCodeMR, RunWorkflowOnSendClaimForApprovalCodeMR);
//             WorkflowEventHandlingMR.RunWorkflowOnApproveApprovalRequestCode:
//                 WorkflowEventHandlingMR.AddEventPredecessor(WorkflowEventHandlingMR.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendClaimForApprovalCodeMR);
//         end;
//     end;

//     /// <summary>
//     /// RunWorkflowOnSendClaimForApprovalCode.
//     /// </summary>
//     /// <returns>Return value of type Code[128].</returns>
//     procedure RunWorkflowOnSendClaimForApprovalCodeMR(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnSendClaimForApprovalMr'))
//     end;

//     /// <summary>
//     /// RunWorkflowOnSendClaimForApproval.
//     /// </summary>
//     /// <param name="Claim">VAR Record "".</param>
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnSendClaimForApprovalMR', '', true, true)]
//     procedure RunWorkflowOnSendClaimForApprovalMR(var MaintenanceHeader: Record "Maintenance Header")
//     begin
//         workflowManagementMR.HandleEvent(RunWorkflowOnSendClaimForApprovalCodeMR, MaintenanceHeader);
//     end;

//     /// <summary>
//     /// RunWorkflowOnCancelClaimApprovalCode.
//     /// </summary>
//     /// <returns>Return value of type Code[128].</returns>
//     procedure RunWorkflowOnCancelClaimApprovalCodeMR(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelClaimApprovalMr'))
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnCancelClaimForApprovalMR', '', true, true)]
//     local procedure RunWorkflowOnCancelClaimApprovalMR(var MaintenanceHeader: Record "Maintenance Header")
//     begin
//         workflowManagementPRQ.HandleEvent(RunWorkflowOnCancelClaimApprovalCodeMR, MaintenanceHeader);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]
//     local procedure OnAddWorkflowCategoriesToLibraryMR()
//     begin
//         WorkflowSetupMR.InsertWorkflowCategory(ClaimWorkflowCategoryTxtMR, ClaimWorkflowCategoryDescTxtMR);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', true, true)]
//     local procedure OnAfterInsertApprovalsTableRelations()
//     var
//         ApprovalEntry: Record 454;
//     begin
//         WorkflowSetupMR.InsertTableRelation(Database::"Maintenance Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]
//     local procedure OnInsertWorkflowTemplatesMR()
//     begin
//         InsertClaimApprovalWorkflowTemplateMR();
//     end;

//     local procedure InsertClaimApprovalWorkflowTemplateMR()
//     var
//         Workflow: Record 1501;
//     begin
//         WorkflowSetupMR.InsertWorkflowTemplate(Workflow, ClaimApprovalWorkflowCodeTxtMR, ClaimApprovalWorkflowDescTxtMR, ClaimWorkflowCategoryTxtMR);
//         InsertClaimApprovalWorkflowDetailsMR(Workflow);
//         WorkflowSetupMR.MarkWorkflowAsTemplate(Workflow);
//     end;

//     local procedure InsertClaimApprovalWorkflowDetailsMR(var Workflow: Record 1501)
//     var
//         WorkflowStepArgument: Record 1523;
//         BlankDateFormula: DateFormula;
//         WorkflowResponseHandling: Codeunit 1521;
//         Claim: Record "Maintenance Header";
//     begin
//         WorkflowSetupMR.InitWorkflowStepArgument(WorkflowStepArgument,
//         WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
//         0, '', BlankDateFormula, true);

//         WorkflowSetupPRQ.InsertDocApprovalWorkflowSteps(
//             Workflow,
//             BuildClaimTypeConditionsMR(Claim.Status::Open),
//             RunWorkflowOnSendClaimForApprovalCodeMR,
//             BuildClaimTypeConditionsMR(Claim.Status::"Pending approval"),
//             RunWorkflowOnCancelClaimApprovalCodeMR,
//             WorkflowStepArgument,
//             true);
//     end;

//     local procedure BuildClaimTypeConditionsMR(Status: Integer): Text
//     var
//         Claim: Record "Maintenance Header";
//     begin
//         Claim.SetRange(Claim.Status, Status);
//         exit(StrSubstNo(ClaimTypeCondTxtMR, WorkflowSetupMR.Encode(Claim.GetView(false))))
//     end;

//     // Workflow Event Handling for Form Request====================
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
//     local procedure OnAddWorkflowEventsToLibraryFM()
//     begin
//         WorkflowEventHandlingFM.AddEventToLibrary(RunWorkflowOnSendClaimForApprovalCodeFM(), Database::"Form Header", ClaimSendForApprovalEventDescTxtFM, 0, false);
//         WorkflowEventHandlingFM.AddEventToLibrary(RunWorkflowOnCancelClaimApprovalCodeFM(), Database::"Form Header", ClaimApprovalRequestCancelEventDescTxtFM, 0, false);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
//     local procedure OnAddWorkflowEventPredecessorsToLibraryFM(EventFunctionName: Code[128])
//     begin
//         case EventFunctionName of
//             RunWorkflowOnCancelClaimApprovalCodeFM:
//                 WorkflowEventHandlingFM.AddEventPredecessor(RunWorkflowOnCancelClaimApprovalCodeFM, RunWorkflowOnSendClaimForApprovalCodeFM);
//             WorkflowEventHandlingFM.RunWorkflowOnApproveApprovalRequestCode:
//                 WorkflowEventHandlingFM.AddEventPredecessor(WorkflowEventHandlingFM.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendClaimForApprovalCodeFM);
//         end;
//     end;

//     /// <summary>
//     /// RunWorkflowOnSendClaimForApprovalCode.
//     /// </summary>
//     /// <returns>Return value of type Code[128].</returns>
//     procedure RunWorkflowOnSendClaimForApprovalCodeFM(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnSendClaimForApprovalFM'))
//     end;

//     /// <summary>
//     /// RunWorkflowOnSendClaimForApproval.
//     /// </summary>
//     /// <param name="Claim">VAR Record "".</param>
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnSendClaimForApprovalFM', '', true, true)]
//     procedure RunWorkflowOnSendClaimForApprovalFM(var FormHeader: Record "Form Header")
//     begin
//         workflowManagementFM.HandleEvent(RunWorkflowOnSendClaimForApprovalCodeFM, FormHeader);
//     end;

//     /// <summary>
//     /// RunWorkflowOnCancelClaimApprovalCode.
//     /// </summary>
//     /// <returns>Return value of type Code[128].</returns>
//     procedure RunWorkflowOnCancelClaimApprovalCodeFM(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelClaimApprovalFm'))
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnCancelClaimForApprovalFM', '', true, true)]
//     local procedure RunWorkflowOnCancelClaimApprovalFM(var FormHeader: Record "Form Header")
//     begin
//         workflowManagementFM.HandleEvent(RunWorkflowOnCancelClaimApprovalCodeFM, FormHeader);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]
//     local procedure OnAddWorkflowCategoriesToLibraryFM()
//     begin
//         WorkflowSetupFM.InsertWorkflowCategory(ClaimWorkflowCategoryTxtFM, ClaimWorkflowCategoryDescTxtFM);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', true, true)]
//     local procedure OnAfterInsertApprovalsTableRelationsFM()
//     var
//         ApprovalEntry: Record 454;
//     begin
//         WorkflowSetupFM.InsertTableRelation(Database::"Form Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]
//     local procedure OnInsertWorkflowTemplatesFM()
//     begin
//         InsertClaimApprovalWorkflowTemplateFM();
//     end;

//     local procedure InsertClaimApprovalWorkflowTemplateFM()
//     var
//         Workflow: Record 1501;
//     begin
//         WorkflowSetupFM.InsertWorkflowTemplate(Workflow, ClaimApprovalWorkflowCodeTxtFM, ClaimApprovalWorkflowDescTxtFM, ClaimWorkflowCategoryTxtFM);
//         InsertClaimApprovalWorkflowDetailsFM(Workflow);
//         WorkflowSetupFM.MarkWorkflowAsTemplate(Workflow);
//     end;

//     local procedure InsertClaimApprovalWorkflowDetailsFM(var Workflow: Record 1501)
//     var
//         WorkflowStepArgument: Record 1523;
//         BlankDateFormula: DateFormula;
//         WorkflowResponseHandling: Codeunit 1521;
//         Claim: Record "Form Header";
//     begin
//         WorkflowSetupFM.InitWorkflowStepArgument(WorkflowStepArgument,
//         WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
//         0, '', BlankDateFormula, true);

//         WorkflowSetupFM.InsertDocApprovalWorkflowSteps(
//             Workflow,
//             BuildClaimTypeConditionsFM(Claim.Status::Open),
//             RunWorkflowOnSendClaimForApprovalCodeFM,
//             BuildClaimTypeConditionsFM(Claim.Status::"Pending approval"),
//             RunWorkflowOnCancelClaimApprovalCodeFM,
//             WorkflowStepArgument,
//             true);
//     end;

//     local procedure BuildClaimTypeConditionsFM(Status: Integer): Text
//     var
//         Claim: Record "Form Header";
//     begin
//         Claim.SetRange(Claim.Status, Status);
//         exit(StrSubstNo(ClaimTypeCondTxtFM, WorkflowSetupFM.Encode(Claim.GetView(false))))
//     end;

//     var
//         workflowManagementPRQ: Codeunit 1501;
//         WorkflowEventHandlingPRQ: Codeunit 1520;
//         ClaimSendForApprovalEventDescTxtPRQ: TextConst ENU = 'Approval of a Purchase Requisition document is requested';
//         ClaimApprovalRequestCancelEventDescTxtPRQ: TextConst ENU = 'Approval of a Purchase Requisition document is canceled';

//         WorkflowSetupPRQ: Codeunit 1502;
//         ClaimWorkflowCategoryTxtPRQ: TextConst ENU = 'PRQW';
//         ClaimWorkflowCategoryDescTxtPRQ: TextConst ENU = 'Purchase or Store Requisition Document';
//         ClaimApprovalWorkflowCodeTxtPRQ: TextConst ENU = 'PRQPW';
//         ClaimApprovalWorkfowDescTxtPRQ: TextConst ENU = 'Purchase or Store Requisition Approval Workflow';
//         ClaimTypeCondTxtPRQ: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name=”Claim”>%1</DataItem></DataItems></ReportParameters>';

//         // Workflow Event Handling for Maintenance Request
//         workflowManagementMR: Codeunit 1501;
//         WorkflowEventHandlingMR: Codeunit 1520;
//         ClaimSendForApprovalEventDescTxtMR: TextConst ENU = 'Approval of Maintenance Request document is requested';
//         ClaimApprovalRequestCancelEventDescTxtMR: TextConst ENU = 'Approval of a Maintenance Request document is canceled';
//         FuelSendForApprovalEventDescTxtMR: TextConst ENU = 'Approval of Fuel Request document is requested';
//         FuelApprovalRequestCancelEventDescTxtMR: TextConst ENU = 'Approval of a Fuel Request document is canceled';

//         WorkflowSetupMR: Codeunit 1502;
//         ClaimWorkflowCategoryTxtMR: TextConst ENU = 'MRW';
//         ClaimWorkflowCategoryDescTxtMR: TextConst ENU = 'Maintenance Request Document';
//         ClaimApprovalWorkflowCodeTxtMR: TextConst ENU = 'MRPW';
//         ClaimApprovalWorkflowDescTxtMR: TextConst ENU = 'Maintenance Request Approval Workflow';
//         ClaimTypeCondTxtMR: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name=”maintenance”>%1</DataItem></DataItems></ReportParameters>';

//         // Workflow Event Handling for Form Request
//         workflowManagementFM: Codeunit 1501;
//         WorkflowEventHandlingFM: Codeunit 1520;
//         ClaimSendForApprovalEventDescTxtFM: TextConst ENU = 'Approval of a Form document is requested';
//         ClaimApprovalRequestCancelEventDescTxtFM: TextConst ENU = 'Approval of a Form document is canceled';

//         WorkflowSetupFM: Codeunit 1502;
//         ClaimWorkflowCategoryTxtFM: TextConst ENU = 'FMW';
//         ClaimWorkflowCategoryDescTxtFM: TextConst ENU = 'Form Request Document';
//         ClaimApprovalWorkflowCodeTxtFM: TextConst ENU = 'FMRAW';
//         ClaimApprovalWorkflowDescTxtFM: TextConst ENU = 'Form Request Approval Workflow';
//         ClaimTypeCondTxtFM: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name=form>%1</DataItem></DataItems></ReportParameters>';

// }
codeunit 50006 "Workflow EventHandling Ext"
{
    Permissions = tabledata "ADT Requisition Header" = rim,
    tabledata "Employee Statistics Group" = rimd,
    tabledata Confidential = rimd,
    tabledata "Res. Ledger Entry" = rim;

    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibraryPRQ()
    begin
        WorkflowEventHandlingPRQ.AddEventToLibrary(RunWorkflowOnSendClaimForApprovalCodePRQ(), Database::"ADT Requisition Header", ClaimSendForApprovalEventDescTxtPRQ, 0, false);
        WorkflowEventHandlingPRQ.AddEventToLibrary(RunWorkflowOnCancelClaimApprovalCodePRQ(), Database::"ADT Requisition Header", ClaimApprovalRequestCancelEventDescTxtPRQ, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibraryPRQ(EventFunctionName: Code[128])
    begin
        case EventFunctionName of
            RunWorkflowOnCancelClaimApprovalCodePRQ:
                WorkflowEventHandlingPRQ.AddEventPredecessor(RunWorkflowOnCancelClaimApprovalCodePRQ, RunWorkflowOnSendClaimForApprovalCodePRQ);
            WorkflowEventHandlingPRQ.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandlingPRQ.AddEventPredecessor(WorkflowEventHandlingPRQ.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendClaimForApprovalCodePRQ);
        end;
    end;

    /// <summary>
    /// RunWorkflowOnSendClaimForApprovalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnSendClaimForApprovalCodePRQ(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendClaimForApproval'))
    end;

    /// <summary>
    /// RunWorkflowOnSendClaimForApproval.
    /// </summary>
    /// <param name="Claim">VAR Record "".</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnSendClaimForApprovalPRQ', '', true, true)]
    procedure RunWorkflowOnSendClaimForApprovalPRQ(var Claim: Record "ADT Requisition Header")
    begin
        workflowManagementPRQ.HandleEvent(RunWorkflowOnSendClaimForApprovalCodePRQ, Claim);
    end;

    /// <summary>
    /// RunWorkflowOnCancelClaimApprovalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnCancelClaimApprovalCodePRQ(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelClaimApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnCancelClaimForApprovalPRQ', '', true, true)]
    local procedure RunWorkflowOnCancelClaimApprovalPRQ(var Claim: Record "ADT Requisition Header")
    begin
        workflowManagementPRQ.HandleEvent(RunWorkflowOnCancelClaimApprovalCodePRQ, Claim);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]
    local procedure OnAddWorkflowCategoriesToLibraryPRQ()
    begin
        WorkflowSetupPRQ.InsertWorkflowCategory(ClaimWorkflowCategoryTxtPRQ, ClaimWorkflowCategoryDescTxtPRQ);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', true, true)]
    local procedure OnAfterInsertApprovalsTableRelationsPRQ()
    var
        ApprovalEntry: Record 454;
    begin
        WorkflowSetupPRQ.InsertTableRelation(Database::"ADT Requisition Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]
    local procedure OnInsertWorkflowTemplatesPRQ()
    begin
        InsertClaimApprovalWorkflowTemplatePRQ();
    end;

    local procedure InsertClaimApprovalWorkflowTemplatePRQ()
    var
        Workflow: Record 1501;
    begin
        WorkflowSetupPRQ.InsertWorkflowTemplate(Workflow, ClaimApprovalWorkflowCodeTxtPRQ, ClaimApprovalWorkfowDescTxtPRQ, ClaimWorkflowCategoryTxtPRQ);
        InsertClaimApprovalWorkflowDetailsPRQ(Workflow);
        WorkflowSetupPRQ.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertClaimApprovalWorkflowDetailsPRQ(var Workflow: Record 1501)
    var
        WorkflowStepArgument: Record 1523;
        BlankDateFormula: DateFormula;
        WorkflowResponseHandling: Codeunit 1521;
        Claim: Record "ADT Requisition Header";
    begin
        WorkflowSetupPRQ.InitWorkflowStepArgument(WorkflowStepArgument,
        WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
        0, '', BlankDateFormula, true);

        WorkflowSetupPRQ.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildClaimTypeConditionsPRQ(Claim.Status::Open),
            RunWorkflowOnSendClaimForApprovalCodePRQ,
            BuildClaimTypeConditionsPRQ(Claim.Status::"Pending approval"),
            RunWorkflowOnCancelClaimApprovalCodePRQ,
            WorkflowStepArgument,
            true);
    end;

    local procedure BuildClaimTypeConditionsPRQ(Status: Integer): Text
    var
        Claim: Record "ADT Requisition Header";
    begin
        Claim.SetRange(Claim.Status, Status);
        exit(StrSubstNo(ClaimTypeCondTxtPRQ, WorkflowSetupPRQ.Encode(Claim.GetView(false))))
    end;

    // Workflow Event Handling for Maintenance Request====================
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibraryMR()
    begin
        WorkflowEventHandlingMR.AddEventToLibrary(RunWorkflowOnSendClaimForApprovalCodeMR(), Database::"Maintenance Header", ClaimSendForApprovalEventDescTxtMR, 0, false);
        WorkflowEventHandlingMR.AddEventToLibrary(RunWorkflowOnCancelClaimApprovalCodeMR(), Database::"Maintenance Header", ClaimApprovalRequestCancelEventDescTxtMR, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibraryMR(EventFunctionName: Code[128])
    begin
        case EventFunctionName of
            RunWorkflowOnCancelClaimApprovalCodeMR:
                WorkflowEventHandlingMR.AddEventPredecessor(RunWorkflowOnCancelClaimApprovalCodeMR, RunWorkflowOnSendClaimForApprovalCodeMR);
            WorkflowEventHandlingMR.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandlingMR.AddEventPredecessor(WorkflowEventHandlingMR.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendClaimForApprovalCodeMR);
        end;
    end;

    /// <summary>
    /// RunWorkflowOnSendClaimForApprovalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnSendClaimForApprovalCodeMR(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendClaimForApprovalMr'))
    end;

    /// <summary>
    /// RunWorkflowOnSendClaimForApproval.
    /// </summary>
    /// <param name="Claim">VAR Record "".</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnSendClaimForApprovalMR', '', true, true)]
    procedure RunWorkflowOnSendClaimForApprovalMR(var MaintenanceHeader: Record "Maintenance Header")
    begin
        workflowManagementMR.HandleEvent(RunWorkflowOnSendClaimForApprovalCodeMR, MaintenanceHeader);
    end;

    /// <summary>
    /// RunWorkflowOnCancelClaimApprovalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnCancelClaimApprovalCodeMR(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelClaimApprovalMr'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnCancelClaimForApprovalMR', '', true, true)]
    local procedure RunWorkflowOnCancelClaimApprovalMR(var MaintenanceHeader: Record "Maintenance Header")
    begin
        workflowManagementPRQ.HandleEvent(RunWorkflowOnCancelClaimApprovalCodeMR, MaintenanceHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]
    local procedure OnAddWorkflowCategoriesToLibraryMR()
    begin
        WorkflowSetupMR.InsertWorkflowCategory(ClaimWorkflowCategoryTxtMR, ClaimWorkflowCategoryDescTxtMR);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', true, true)]
    local procedure OnAfterInsertApprovalsTableRelations()
    var
        ApprovalEntry: Record 454;
    begin
        WorkflowSetupMR.InsertTableRelation(Database::"Maintenance Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]
    local procedure OnInsertWorkflowTemplatesMR()
    begin
        InsertClaimApprovalWorkflowTemplateMR();
    end;

    local procedure InsertClaimApprovalWorkflowTemplateMR()
    var
        Workflow: Record 1501;
    begin
        WorkflowSetupMR.InsertWorkflowTemplate(Workflow, ClaimApprovalWorkflowCodeTxtMR, ClaimApprovalWorkflowDescTxtMR, ClaimWorkflowCategoryTxtMR);
        InsertClaimApprovalWorkflowDetailsMR(Workflow);
        WorkflowSetupMR.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertClaimApprovalWorkflowDetailsMR(var Workflow: Record 1501)
    var
        WorkflowStepArgument: Record 1523;
        BlankDateFormula: DateFormula;
        WorkflowResponseHandling: Codeunit 1521;
        Claim: Record "Maintenance Header";
    begin
        WorkflowSetupMR.InitWorkflowStepArgument(WorkflowStepArgument,
        WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
        0, '', BlankDateFormula, true);

        WorkflowSetupPRQ.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildClaimTypeConditionsMR(Claim.Status::Open),
            RunWorkflowOnSendClaimForApprovalCodeMR,
            BuildClaimTypeConditionsMR(Claim.Status::"Pending approval"),
            RunWorkflowOnCancelClaimApprovalCodeMR,
            WorkflowStepArgument,
            true);
    end;

    local procedure BuildClaimTypeConditionsMR(Status: Integer): Text
    var
        Claim: Record "Maintenance Header";
    begin
        Claim.SetRange(Claim.Status, Status);
        exit(StrSubstNo(ClaimTypeCondTxtMR, WorkflowSetupMR.Encode(Claim.GetView(false))))
    end;

    // Workflow Event Handling for Form Request====================
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibraryFM()
    begin
        WorkflowEventHandlingFM.AddEventToLibrary(RunWorkflowOnSendClaimForApprovalCodeFM(), Database::"Form Header", ClaimSendForApprovalEventDescTxtFM, 0, false);
        WorkflowEventHandlingFM.AddEventToLibrary(RunWorkflowOnCancelClaimApprovalCodeFM(), Database::"Form Header", ClaimApprovalRequestCancelEventDescTxtFM, 0, false);
       // WorkflowEventHandlingFM.AddEventToLibrary(RunWorkflowOnRejectClaimApprovalCodeFM(), Database::"Form Header", ClaimApprovalRequestRejectEventDescTxtFM, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibraryFM(EventFunctionName: Code[128])
    begin
        case EventFunctionName of
            RunWorkflowOnCancelClaimApprovalCodeFM:
                WorkflowEventHandlingFM.AddEventPredecessor(RunWorkflowOnCancelClaimApprovalCodeFM, RunWorkflowOnSendClaimForApprovalCodeFM);
            WorkflowEventHandlingFM.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandlingFM.AddEventPredecessor(WorkflowEventHandlingFM.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendClaimForApprovalCodeFM);
        end;
    end;

    /// <summary>
    /// RunWorkflowOnSendClaimForApprovalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnSendClaimForApprovalCodeFM(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendClaimForApprovalFM'))
    end;

    /// <summary>
    /// RunWorkflowOnSendClaimForApproval.
    /// </summary>
    /// <param name="Claim">VAR Record "".</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnSendClaimForApprovalFM', '', true, true)]
    procedure RunWorkflowOnSendClaimForApprovalFM(var FormHeader: Record "Form Header")
    begin
        workflowManagementFM.HandleEvent(RunWorkflowOnSendClaimForApprovalCodeFM, FormHeader);
    end;

    // procedure RunWorkflowOnRejectClaimForApprovalCodeFM(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnRejectClaimForApprovalFM'))
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnSendClaimForApprovalFM', '', true, true)]
    // procedure RunWorkflowOnRejectClaimForApprovalFM(var FormHeader: Record "Form Header")
    // begin
    //     workflowManagementFM.HandleEvent(RunWorkflowOnRejectClaimForApprovalCodeFM, FormHeader);
    // end;

    /// <summary>
    /// RunWorkflowOnCancelClaimApprovalCode.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnCancelClaimApprovalCodeFM(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelClaimApprovalFm'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnCancelClaimForApprovalFM', '', true, true)]
    local procedure RunWorkflowOnCancelClaimApprovalFM(var FormHeader: Record "Form Header")
    begin
        workflowManagementFM.HandleEvent(RunWorkflowOnCancelClaimApprovalCodeFM, FormHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]
    local procedure OnAddWorkflowCategoriesToLibraryFM()
    begin
        WorkflowSetupFM.InsertWorkflowCategory(ClaimWorkflowCategoryTxtFM, ClaimWorkflowCategoryDescTxtFM);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', true, true)]
    local procedure OnAfterInsertApprovalsTableRelationsFM()
    var
        ApprovalEntry: Record 454;
    begin
        WorkflowSetupFM.InsertTableRelation(Database::"Form Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]
    local procedure OnInsertWorkflowTemplatesFM()
    begin
        InsertClaimApprovalWorkflowTemplateFM();
    end;

    local procedure InsertClaimApprovalWorkflowTemplateFM()
    var
        Workflow: Record 1501;
    begin
        WorkflowSetupFM.InsertWorkflowTemplate(Workflow, ClaimApprovalWorkflowCodeTxtFM, ClaimApprovalWorkflowDescTxtFM, ClaimWorkflowCategoryTxtFM);
        InsertClaimApprovalWorkflowDetailsFM(Workflow);
        WorkflowSetupFM.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertClaimApprovalWorkflowDetailsFM(var Workflow: Record 1501)
    var
        WorkflowStepArgument: Record 1523;
        BlankDateFormula: DateFormula;
        WorkflowResponseHandling: Codeunit 1521;
        Claim: Record "Form Header";
    begin
        WorkflowSetupFM.InitWorkflowStepArgument(WorkflowStepArgument,
        WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
        0, '', BlankDateFormula, true);

        WorkflowSetupFM.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildClaimTypeConditionsFM(Claim.Status::Open),
            RunWorkflowOnSendClaimForApprovalCodeFM,
            BuildClaimTypeConditionsFM(Claim.Status::"Pending approval"),
            RunWorkflowOnCancelClaimApprovalCodeFM,
            // BuildClaimTypeConditionsFM(Claim.Status::"Pending Approval"),
            // RunWorkflowOnRejectClaimApprovalCodeFM(),
            WorkflowStepArgument,
            true);
    end;

    local procedure BuildClaimTypeConditionsFM(Status: Integer): Text
    var
        Claim: Record "Form Header";
    begin
        Claim.SetRange(Claim.Status, Status);
        exit(StrSubstNo(ClaimTypeCondTxtFM, WorkflowSetupFM.Encode(Claim.GetView(false))))
    end;

    // Workflow Event Handling for Cash Purchase====================
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibraryCP()
    begin
        WorkflowEventHandlingCP.AddEventToLibrary(RunWorkflowOnSendClaimForApprovalCodeCP(), Database::"Cash Purchase", ClaimSendForApprovalEventDescTxtCP, 0, false);
        WorkflowEventHandlingCP.AddEventToLibrary(RunWorkflowOnCancelClaimApprovalCodeCP(), Database::"Cash Purchase", ClaimApprovalRequestCancelEventDescTxtCP, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibraryCP(EventFunctionName: Code[128])
    begin
        case EventFunctionName of
            RunWorkflowOnCancelClaimApprovalCodeCP:
                WorkflowEventHandlingCP.AddEventPredecessor(RunWorkflowOnCancelClaimApprovalCodeCP, RunWorkflowOnSendClaimForApprovalCodeCP);
            WorkflowEventHandlingCP.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandlingCP.AddEventPredecessor(WorkflowEventHandlingCP.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendClaimForApprovalCodeCP);
        end;
    end;

    // incident 
    

    /// <summary>
    /// RunWorkflowOnSendClaimForApprovalCodeCP.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnSendClaimForApprovalCodeCP(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendClaimForApprovalCp'))
    end;

    /// <summary>
    /// RunWorkflowOnSendClaimForApprovalCP.
    /// </summary>
    /// <param name="CashPurchase">VAR Record "Cash Purchase".</param>
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnSendClaimForApprovalCP', '', true, true)]
    // procedure RunWorkflowOnSendClaimForApprovalCP(var CashPurchase: Record "Cash Purchase")
    // begin
    //     workflowManagementCP.HandleEvent(RunWorkflowOnSendClaimForApprovalCodeCP, CashPurchase);
    // end;

    /// <summary>
    /// RunWorkflowOnCancelClaimApprovalCodeCP.
    /// </summary>
    /// <returns>Return value of type Code[128].</returns>
    procedure RunWorkflowOnCancelClaimApprovalCodeCP(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelClaimApprovalCp'))
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Fleet Management", 'OnCancelClaimForApprovalCP', '', true, true)]
    // local procedure RunWorkflowOnCancelClaimApprovalCP(var CashPurchase: Record "Cash Purchase")
    // begin
    //     workflowManagementCP.HandleEvent(RunWorkflowOnCancelClaimApprovalCodeCP, CashPurchase);
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]
    local procedure OnAddWorkflowCategoriesToLibraryCP()
    begin
        WorkflowSetupCP.InsertWorkflowCategory(ClaimWorkflowCategoryTxtCP, ClaimWorkflowCategoryDescTxtCP);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', true, true)]
    local procedure OnAfterInsertApprovalsTableRelationsCP()
    var
        ApprovalEntry: Record 454;
    begin
        WorkflowSetupCP.InsertTableRelation(Database::"Cash Purchase", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]
    local procedure OnInsertWorkflowTemplatesCP()
    begin
        InsertClaimApprovalWorkflowTemplateCP();
    end;

    local procedure InsertClaimApprovalWorkflowTemplateCP()
    var
        Workflow: Record 1501;
    begin
        WorkflowSetupCP.InsertWorkflowTemplate(Workflow, ClaimApprovalWorkflowCodeTxtCP, ClaimApprovalWorkflowDescTxtCP, ClaimWorkflowCategoryTxtCP);
        InsertClaimApprovalWorkflowDetailsCP(Workflow);
        WorkflowSetupCP.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertClaimApprovalWorkflowDetailsCP(var Workflow: Record 1501)
    var
        WorkflowStepArgument: Record 1523;
        BlankDateFormula: DateFormula;
        WorkflowResponseHandling: Codeunit 1521;
        CashPurchase: Record "Cash Purchase";
    begin
        WorkflowSetupCP.InitWorkflowStepArgument(WorkflowStepArgument,
        WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
        0, '', BlankDateFormula, true);

        WorkflowSetupCP.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildClaimTypeConditionsCP(CashPurchase.Status::Open),
            RunWorkflowOnSendClaimForApprovalCodeCP,
            BuildClaimTypeConditionsCP(CashPurchase.Status::"Pending approval"),
            RunWorkflowOnCancelClaimApprovalCodeCP,
            WorkflowStepArgument,
            true);
    end;


[EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling",
 'OnAddWorkflowResponsesToLibrary', '', false, false)]
local procedure AddCashPurchaseWorkflowResponses()
var
    WorkflowResponseHandling: Codeunit "Workflow Response Handling";
begin
    
    WorkflowResponseHandling.AddResponseToLibrary(
        GetCreateCashPurchaseApprovalRequestCode(),
        Database::"Cash Purchase", // TableID
        'Create an approval request for Cash Purchase %1 using approver type %2',
        'CASH PURCHASE');

    WorkflowResponseHandling.AddResponseToLibrary(
        GetSendCashPurchaseApprovalRequestCode(),
        Database::"Cash Purchase", // TableID
        'Send approval request for Cash Purchase and create notification',
        'CASH PURCHASE');

    WorkflowResponseHandling.AddResponseToLibrary(
        GetReleaseCashPurchaseDocumentCode(),
        Database::"Cash Purchase", // TableID
        'Release the Cash Purchase document',
        'CASH PURCHASE');

    WorkflowResponseHandling.AddResponseToLibrary(
        GetRejectCashPurchaseDocumentCode(),
        Database::"Cash Purchase", // TableID
        'Reject the Cash Purchase document',
        'CASH PURCHASE');
    //recently
    WorkflowResponseHandling.AddResponseToLibrary(
        GetSetCashPurchasePendingApprovalCode(),
        Database::"Cash Purchase", // TableID
        'Set Cash Purchase to Rejected',
        'CASH PURCHASE');
    
end;

    local procedure GetSetCashPurchasePendingApprovalCode(): Code[128]
    var
    CashPurchase: Record "Cash Purchase";
    RecVariant: Variant;
begin
    
    if not RecVariant.IsRecord then
        exit;

    CashPurchase := RecVariant;

    CashPurchase.Status := CashPurchase.Status::"Pending Approval";
    //CashPurchase.Status := CashPurchase.Status::"Rejected";
                CashPurchase.Modify(true);

    // case ResponseCode of
    //     GetSetPendingApprovalCode():
    //         begin
    //             CashPurchase.Status := CashPurchase.Status::"Pending Approval";
    //             CashPurchase.Modify(true);
    //         end;
    // end;
    exit('SETCASHPURCHASEPENDINGAPPROVAL');
end;

local procedure GetCreateCashPurchaseApprovalRequestCode(): Code[128]
var
    CashPurchase: Record "Cash Purchase";
    RecVariant: Variant;
begin
    Codeunit.Run(Codeunit::"Approvals Mgmt.", CashPurchase);
    exit('CREATECASHPURCHASEAPPROVALREQUEST');
end;

local procedure GetSendCashPurchaseApprovalRequestCode(): Code[128]
var
  CashPurchase: Record "Cash Purchase";
begin
     // Send + notify
                Codeunit.Run(Codeunit::"Approvals Mgmt.", CashPurchase);
                // optionally add notification logic
    exit('SENDCASHPURCHASEAPPROVALREQUEST');
end;

local procedure GetReleaseCashPurchaseDocumentCode(): Code[128]
var 
 CashPurchase: Record "Cash Purchase";
begin
    CashPurchase.Status := CashPurchase.Status::Released;
     //   CashPurchase.Modify(true);
    exit('RELEASECASHPURCHASE');
end;

procedure GetRejectCashPurchaseDocumentCode(): Code[128]
var 
 CashPurchase: Record "Cash Purchase";
begin
    CashPurchase.Status := CashPurchase.Status::Rejected;
    // CashPurchase.Modify(true);
    
    exit('REJECTCASHPURCHASE');
end;

    local procedure BuildClaimTypeConditionsCP(Status: Integer): Text
    var
        CashPurchase: Record "Cash Purchase";
    begin
        CashPurchase.SetRange(CashPurchase.Status, Status);
        exit(StrSubstNo(ClaimTypeCondTxtCP, WorkflowSetupCP.Encode(CashPurchase.GetView(false))))
    end;


    
// ...existing code...

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling",
     'OnAddWorkflowResponsesToLibrary', '', false, false)]
    local procedure AddFormWorkflowResponses()
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        // WorkflowResponseHandling.AddResponseToLibrary(
        //     GetCreateFormApprovalRequestCode(),
        //     Database::"Form Header",
        //     'Create an approval request for the form document %1 using approver type %2',
        //     'FORM HEADER');

        // WorkflowResponseHandling.AddResponseToLibrary(
        //     GetSendFormApprovalRequestCode(),
        //     Database::"Form Header",
        //     'Send approval request for the form document and create notification',
        //     'FORM HEADER');

        // WorkflowResponseHandling.AddResponseToLibrary(
        //     GetSetFormPendingApprovalCode(),
        //     Database::"Form Header",
        //     'Set document status to Pending Approval',
        //     'FORM HEADER');

        WorkflowResponseHandling.AddResponseToLibrary(
            GetRejectFormDocumentCode(),
            Database::"Form Header",
            'Form document rejected',
            'FORM HEADER');

        WorkflowResponseHandling.AddResponseToLibrary(
            GetSetFormStatusToRejectedCode(),
            Database::"Form Header",
            'Set document status to Rejected',
            'FORM HEADER');

        // WorkflowResponseHandling.AddResponseToLibrary(
        //     GetReleaseFormDocumentCode(),
        //     Database::"Form Header",
        //     'Release the form document',
        //     'FORM HEADER');
    end;

    local procedure GetFormRejectResponseCode(): Code[128]
        begin
            exit(UpperCase('SetFormStatusToRejected'));
        end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling",
     'OnExecuteWorkflowResponse', '', false, false)]
    local procedure ExecuteFormWorkflowResponse(var ResponseExecuted: Boolean; var Variant: Variant)
    var
        RecRef: RecordRef;
        FormHeader: Record "Form Header";
    begin
        if not Variant.IsRecord then
            exit;

        RecRef.GetTable(Variant);
        if RecRef.Number <> Database::"Form Header" then
            exit;

        RecRef.SetTable(FormHeader);
        case ResponseCode of
            // GetCreateFormApprovalRequestCode():
            //     Codeunit.Run(Codeunit::"Approvals Mgmt.", FormHeader);

            // GetSendFormApprovalRequestCode():
            //     begin
            //         Codeunit.Run(Codeunit::"Approvals Mgmt.", FormHeader);
            //         // add notification logic here if required
            //     end;

            // GetSetFormPendingApprovalCode():
            //     begin
            //         FormHeader.Validate(Status, FormHeader.Status::"Pending approval");
            //         FormHeader.Modify(true);
            //     end;

            GetRejectFormDocumentCode(),
            GetSetFormStatusToRejectedCode():
                begin
                    FormHeader.Validate(Status, FormHeader.Status::Rejected);
                    FormHeader.Modify(true);
                end;

            // GetReleaseFormDocumentCode():
            //     begin
            //         FormHeader.Validate(Status, FormHeader.Status::Released);
            //         FormHeader.Modify(true);
            //     end;
        end;

        //Handled := true;
    end;

    // local procedure GetCreateFormApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('CreateFormApprovalRequest'));
    // end;

    // local procedure GetSendFormApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('SendFormApprovalRequest'));
    // end;

    // local procedure GetSetFormPendingApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('SetFormPendingApproval'));
    // end;

    local procedure GetRejectFormDocumentCode(): Code[128]
    begin
        exit(UpperCase('FormDocumentRejected'));
    end;

    local procedure GetSetFormStatusToRejectedCode(): Code[128]
    begin
        
        exit(UpperCase('SetFormStatusToRejected'));
    end;

    // local procedure GetReleaseFormDocumentCode(): Code[128]
    // begin
    //     exit(UpperCase('ReleaseFormDocument'));
    // end;

// ...existing code...

    
    var
        workflowManagementPRQ: Codeunit 1501;
        WorkflowEventHandlingPRQ: Codeunit 1520;
        ClaimSendForApprovalEventDescTxtPRQ: TextConst ENU = 'Approval of a Purchase Requisition document is requested';
        ClaimApprovalRequestCancelEventDescTxtPRQ: TextConst ENU = 'Approval of a Purchase Requisition document is canceled';

        WorkflowSetupPRQ: Codeunit 1502;
        ClaimWorkflowCategoryTxtPRQ: TextConst ENU = 'PRQW';
        ClaimWorkflowCategoryDescTxtPRQ: TextConst ENU = 'Purchase or Store Requisition Document';
        ClaimApprovalWorkflowCodeTxtPRQ: TextConst ENU = 'PRQPW';
        ClaimApprovalWorkfowDescTxtPRQ: TextConst ENU = 'Purchase or Store Requisition Approval Workflow';
        ClaimTypeCondTxtPRQ: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="Claim">%1</DataItem></DataItems></ReportParameters>';

        // Workflow Event Handling for Maintenance Request
        workflowManagementMR: Codeunit 1501;
        WorkflowEventHandlingMR: Codeunit 1520;
        ClaimSendForApprovalEventDescTxtMR: TextConst ENU = 'Approval of Maintenance Request document is requested';
        ClaimApprovalRequestCancelEventDescTxtMR: TextConst ENU = 'Approval of a Maintenance Request document is canceled';
        FuelSendForApprovalEventDescTxtMR: TextConst ENU = 'Approval of Fuel Request document is requested';
        FuelApprovalRequestCancelEventDescTxtMR: TextConst ENU = 'Approval of a Fuel Request document is canceled';

        WorkflowSetupMR: Codeunit 1502;
        ClaimWorkflowCategoryTxtMR: TextConst ENU = 'MRW';
        ClaimWorkflowCategoryDescTxtMR: TextConst ENU = 'Maintenance Request Document';
        ClaimApprovalWorkflowCodeTxtMR: TextConst ENU = 'MRPW';
        ClaimApprovalWorkflowDescTxtMR: TextConst ENU = 'Maintenance Request Approval Workflow';
        ClaimTypeCondTxtMR: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="maintenance">%1</DataItem></DataItems></ReportParameters>';

        // Workflow Event Handling for Form Request
        workflowManagementFM: Codeunit 1501;
        WorkflowEventHandlingFM: Codeunit 1520;
        ClaimSendForApprovalEventDescTxtFM: TextConst ENU = 'Approval of a Form document is requested';
        ClaimApprovalRequestCancelEventDescTxtFM: TextConst ENU = 'Approval of a Form document is canceled';

        WorkflowSetupFM: Codeunit 1502;
        ClaimWorkflowCategoryTxtFM: TextConst ENU = 'FMW';
        ClaimWorkflowCategoryDescTxtFM: TextConst ENU = 'Form Request Document';
        ClaimApprovalWorkflowCodeTxtFM: TextConst ENU = 'FMRAW';
        ClaimApprovalWorkflowDescTxtFM: TextConst ENU = 'Form Request Approval Workflow';
        ClaimTypeCondTxtFM: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=form>%1</DataItem></DataItems></ReportParameters>';

        // Workflow Event Handling for Cash Purchase
        workflowManagementCP: Codeunit 1501;
        WorkflowEventHandlingCP: Codeunit 1520;
        ClaimSendForApprovalEventDescTxtCP: TextConst ENU = 'Approval of a Cash Purchase document is requested';
        ClaimApprovalRequestCancelEventDescTxtCP: TextConst ENU = 'Approval of a Cash Purchase document is canceled';
        ClaimApprovalRequestRejectEventDescTxtCP: TextConst ENU = 'Approval of a Cash Purchase document is rejected';

        WorkflowSetupCP: Codeunit 1502;
        ClaimWorkflowCategoryTxtCP: TextConst ENU = 'CPW';
        ClaimWorkflowCategoryDescTxtCP: TextConst ENU = 'Cash Purchase Document';
        ClaimApprovalWorkflowCodeTxtCP: TextConst ENU = 'CPRAW';
        ClaimApprovalWorkflowDescTxtCP: TextConst ENU = 'Cash Purchase Approval Workflow';
        ClaimTypeCondTxtCP: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="cashpurchase">%1</DataItem></DataItems></ReportParameters>';
        ResponseCode : Code[128];

}

