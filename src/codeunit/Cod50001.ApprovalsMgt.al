codeunit 50010"ApprovalsMgt"
{
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";

    procedure InitCustomApprovalWorkflows()
    var
        WorkflowResponse: Record "Workflow Response";
        ExtApprovalsHandler: Codeunit Workflow_Approval;
    begin
        if WorkflowResponse.Get(UpperCase('ASLSendApprovalRequestForApproval')) then
            WorkflowResponse.Delete();

        if WorkflowResponse.Get(UpperCase('ASLCancelAllApprovalRequests')) then
            WorkflowResponse.Delete();

        OnAddExtWorkflowEventsToLibrary();
        OnAddExtflowResponsesToLibrary();
        // Add response predecessors for base responses to be linked to custom events
        OnAddBaseWorkflowResponsePredecessorsToLibrary();
        OnInsertExtWorkflowCategories();
        OnInsertExtWorkflowTemplates();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAddExtWorkflowEventsToLibrary()
    begin
    end;

    /// <summary>
    /// subscribe to this to add custom workflow responses
    /// </summary>
    [IntegrationEvent(false, false)]
    procedure OnAddExtflowResponsesToLibrary()
    begin
    end;

    /// <summary>
    /// subscribe to this to add response predecessors for base responses to be linked to custom events
    /// </summary>
    [IntegrationEvent(false, false)]
    local procedure OnAddBaseWorkflowResponsePredecessorsToLibrary()
    begin
    end;

    /// <summary>
    /// subscribe to this to add custom workflow categories
    /// </summary>
    [IntegrationEvent(false, false)]
    local procedure OnInsertExtWorkflowCategories()
    begin
    end;

    /// <summary>
    /// subscribe to this to add custom workflow templates
    /// </summary>
    [IntegrationEvent(false, false)]
    local procedure OnInsertExtWorkflowTemplates()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        OnAddExtWorkflowEventsToLibrary();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsesToLibrary()
    begin
        OnAddExtflowResponsesToLibrary();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]
    local procedure OnAddWorkflowCategoriesToLibrary()
    begin
        OnInsertExtWorkflowCategories();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]
    local procedure OnInsertWorkflowTemplates()
    begin
        OnInsertExtWorkflowTemplates();
    end;

    procedure OpenApprovalEntriesPage(RecId: RecordID)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Table ID", RecId.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecId);
        ApprovalEntry.SetRange("Related to Change", false);
        PAGE.Run(PAGE::"Approval Entries", ApprovalEntry);
    end;
}