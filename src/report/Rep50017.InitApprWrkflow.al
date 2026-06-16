report 50017 "InitApprWrkflow_"
{
    Caption = 'Initialize Approval Workflows';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = false;

    trigger OnPostReport()
    var
        CustomApprovalsMgt: Codeunit "ApprovalsMgt";
        WorkflowEvent: Record "Workflow Event";
        WorkflowResponse: Record "Workflow Response";
        WorkflowStep: Record "Workflow Step";
        WorkflowCategory: Record "Workflow Category";
        
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEvent.DeleteAll();
        WorkflowEventHandling.CreateEventsLibrary();
        CustomApprovalsMgt.InitCustomApprovalWorkflows();
    end;
}