page 50028 "Maintenance Job Card"
{
    Caption = 'Maintenance Job';
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTable = "Maintenance Header";
    DataCaptionFields = "No.", "Equipment No.", "Equipment Name";
    SourceTableView = WHERE("Document Type" = FILTER("Job Card"));

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    Editable = not JobClosed;
                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                    Editable = not JobClosed;
                }
                field("Maintenance Request No."; Rec."Maintenance Request No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maintenance Request No. field.', Comment = '%';
                    Editable = false;
                }
                field("Maintenance Request Date"; Rec."Maintenance Request Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Maintenance Request Date field.', Comment = '%';
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                    Editable = not JobClosed;
                }
                field("Equipment Name"; Rec."Equipment Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Name field.', Comment = '%';
                    Editable = false;
                }
                field("Equipment Make"; Rec."Equipment Make")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Make field.', Comment = '%';
                    Editable = false;
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                }
                field("Equipment Model"; Rec."Equipment Model")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment Model field.', Comment = '%';
                }
                field("Equipment Serial No."; Rec."Equipment Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Serial No. field.', Comment = '%';
                    Editable = false;
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver No. field.', Comment = '%';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                }
                field("Odometer Reading (Km/Hrs)"; Rec."Odometer Reading (Km/Hrs)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Odometer Reading (Km/Hrs) field.', Comment = '%';
                    Editable = not JobClosed;
                }

                field("Report Summary"; Rec."Report Summary")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Request Summary field.', Comment = '%';
                    Editable = not JobClosed;
                }
                field(Mechanic; Rec.Mechanic)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mechanic field.', Comment = '%';
                    Editable = not JobClosed;
                }
                field("Mechanic Name"; Rec."Mechanic Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mechanic Name field.', Comment = '%';
                    Editable = not JobClosed;
                }
                field("Job Status"; Rec."Job Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Job Status field.', Comment = '%';
                }
                field("Job Authorized"; Rec."Job Authorized")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Cost field.', Comment = '%';
                    Editable = false;
                }
                field("User ID"; Rec."Prepared by")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                    Editable = false; 
                    trigger OnValidate()
                    begin
    
                      Rec."Prepared by" := UserId;
                    end;
                }
                field("Checklist No"; Rec."CheckList No.")
                {
                    ApplicationArea = All;
                    Caption = 'Checklist No';
                    Editable = false;
                }
                group(OtherComments)
                {
                    Caption = 'Other Comments';
                    field("Other Comments"; Rec."Other Comments")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        ToolTip = 'Specifies the value of the Other Comments field.', Comment = '%';
                        Editable = not JobClosed;
                    }
                }
            }
            part("Maintenance Requirements"; "Maintenance Job Card Subform")
            {
                Caption = 'Details';
                Editable = not JobClosed;
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Verification)
            {
                field("Workshop Manager No."; Rec."Workshop Manager No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Workshop Manager No. field.', Comment = '%';
                    Editable = not JobClosed;
                }
                field("Workshop Manager Name"; Rec."Workshop Manager Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Workshop Manager Name field.', Comment = '%';
                    Editable = not JobClosed;
                }
                field("Workshop Manager Date"; Rec."Workshop Manager Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Workshop Manager Date field.', Comment = '%';
                    Editable = not JobClosed;
                }
                field("Signed By Workshop Manager"; Rec."Signed By Workshop Manager")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Signed By Workshop Manager field.', Comment = '%';
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                    Editable = not JobClosed;
                }
            }
        }

        area(Factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Maintenance Header"), "No." = FIELD("No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(Start)
                {
                    ApplicationArea = All;
                    Caption = 'Start Job';
                    Image = Start;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to start this job?', true) then begin
                            StartJob();
                        end;
                    end;
                }
                action(Close)
                {
                    ApplicationArea = All;
                    Caption = 'Close Job';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to close this job?', true) then begin
                            CloseJob();
                            CurrPage.Update(false);
                        end;
                    end;
                }
                action(Cancel)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Job';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to cancel this job?', true) then begin
                            CancelJob();
                            CurrPage.Update(false);
                        end;
                    end;
                }
                action(Authorize)
                {
                    ApplicationArea = All;
                    Caption = 'Authorize Job';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Authorize this job?', true) then
                            AuthorizeJob();
                        CurrPage.Update(false);
                    end;
                }
                action(SignOff)
                {
                    ApplicationArea = All;
                    Caption = 'SignOff A Job';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to SignOff this job?', true) then
                            WorkshopManagerSignOff();
                        CurrPage.Update(false);
                    end;
                }
                action("Create SPR")
                {
                    ApplicationArea = All;
                    Caption = 'Create Spare Parts Requisition';
                    Image = NewDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        // Code to create a spare parts requisition linked to this job card
                        if Confirm('Are you sure you want to create a Spare Parts Requisition for this job?', true) then begin
                            CreateSPRfromJob(Rec);
                            CurrPage.Update(false);
                        end;
                    end;
                

                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        RequisitionHeader: Record "Maintenance Header";
                        MaintenanceReport: Report "Maintenance Job Card";
                    begin
                        RequisitionHeader.SETRANGE("Document Type", RequisitionHeader."Document Type"::"Job Card");
                        RequisitionHeader.SETRANGE("No.", Rec."No.");
                        MaintenanceReport.SETTABLEVIEW(RequisitionHeader);
                        MaintenanceReport.RUNMODAL;
                    end;
                }
            }
        }
        area(Navigation)
        {
            group(Job)
            {
                Caption = 'Job';

                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = filter("Job Card"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction();
                    begin
                        // Rec.ShowDocDim;
                    end;
                }
                action(DocAttachments)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()

    begin
        if Rec."Job Status" = Rec."Job Status"::Closed then
            JobClosed := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        
        Rec."Prepared by" := UserId;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        MaintenanceHeader: Record "Maintenance Header";
    begin
        MaintenanceHeader.Reset();
        MaintenanceHeader.SetRange("Document Type", MaintenanceHeader."Document Type"::"Maintenance Request");
        MaintenanceHeader.SetRange("No.", Rec."Maintenance Request No.");
        if MaintenanceHeader.FindFirst() then begin
            MaintenanceHeader."Has a Job" := false;
            MaintenanceHeader.Modify();
        end;
    end;

    var
        Equipment: Record "Fixed Asset";
        JobClosed: Boolean;

    Local procedure StartJob()
    var
        Equipment: Record "Fixed Asset";
    begin
        CheckMaintenanceRequest();
        CheckJobCardLines();
        Rec.TestField("No.");
        Rec.TestField("Posting Date");
        Rec.TestField("Equipment No.");
        Rec.TestField("Equipment Name");
        Rec.TestField("Equipment Make");
        Rec.TestField("Odometer Reading (Km/Hrs)");
        Rec.TestField("Job Authorized", true);
        Rec.TestField("Maintenance Request No.");
        Rec.TestField("Maintenance Request Date");
        Rec.TestField("Job Status", Rec."Job Status"::New);
        Rec."Job Status" := Rec."Job Status"::"In Progress";
        Rec."Job Start Date" := Today;
        Rec."Job Start By" := UserId;
        Rec."Job End Date" := 0D; // Reset Job End Date
        Rec."Job Cancel Date" := 0D; // Reset Job Cancel Date
        Rec.Modify(true);

        //update the Equipment Status
        if Equipment.Get(Rec."Equipment No.") then begin
            if Equipment."Equipment Status" <> Equipment."Equipment Status"::"At Workshop" then begin
                Equipment."Equipment Status" := Equipment."Equipment Status"::"At Workshop";
                Equipment.Modify(true);
            end else
                Error('Equipment No. %1 is already at workshop.', Rec."Equipment No.");
        end else
            Error('Equipment No. %1 not found.', Rec."Equipment No.");
    end;

    Local procedure CloseJob()
    var
        SpareParts: Record "ADT Requisition Header";
        Stamina : Record "Form Header";
    begin
        SpareParts.Reset();
        SpareParts.SetRange("Document Type", SpareParts."Document Type"::"Purchase Requisition");
        SpareParts.SetRange("Request Type", SpareParts."Request Type"::"Spare Parts");
        SpareParts.SetRange("Job Card No.", Rec."No.");
        if SpareParts.FindFirst() then begin
            if SpareParts.Transferred = false then
                Error('You cannot close this job as there are outstanding Spare Parts Requisitions linked to this job that have not been transferred. Please transfer requisitions before closing the job.');
        end else begin
            Error('This Job does not have any Spare Parts Requisitions.');
        end;

        CheckMaintenanceRequest();
        CheckJobCardLines();
        Rec.TestField("No.");
        Rec.TestField("Posting Date");
        Rec.TestField("Equipment No.");
        Rec.TestField("Equipment Name");
        Rec.TestField("Odometer Reading (Km/Hrs)");
        Rec.TestField("Job Authorized", true);
        Rec.TestField("Maintenance Request No.");
        Rec.TestField("Maintenance Request Date");
        Rec.TestField("Report Summary");
        Rec.TestField("Other Comments");
        Rec.TestField("Workshop Manager No.");
        Rec.TestField("Mechanic");
        Rec.TestField("Signed By Workshop Manager", true);
        Rec.TestField(Remarks);
        Rec.TestField("Job Status", Rec."Job Status"::"In Progress");
        Rec."Job Status" := Rec."Job Status"::Closed;
        Rec."Job End Date" := Today;
        Rec."Job Ended By" := UserId;

       // update checklist state from Faulty -> Fixed (if linked)
            Stamina.Reset();
            Stamina.SetRange("Document Type", Stamina."Document Type"::"Equipment Inspection");
            Stamina.SetRange("No.", Rec."Checklist No.");
            if Stamina.FindFirst() then begin
                if Stamina.State = Stamina.State::Faulty then begin
                    Stamina.State := Stamina.State::Fixed;
                    Stamina.Modify(true);
                end;
            end;

        Rec.Modify(true);

        //update the Equipment Status
        if Equipment.Get(Rec."Equipment No.") then begin
            if Equipment."Equipment Status" = Equipment."Equipment Status"::"At Workshop" then begin
                Equipment."Equipment Status" := Equipment."Equipment Status"::Available;
                Equipment.Modify(true);
            end else
                Error('Equipment No. %1 is not at the workshop.', Rec."Equipment No.");
        end else
            Error('Equipment No. %1 not found.', Rec."Equipment No.");
    end;

    //Cancel the Job only if it is in Progress
    Local procedure CancelJob()
    begin
        CheckMaintenanceRequest();
        CheckJobCardLines();
        Rec.TestField("No.");
        Rec.TestField("Posting Date");
        Rec.TestField("Equipment No.");
        Rec.TestField("Equipment Name");
        Rec.TestField("Odometer Reading (Km/Hrs)");
        Rec.TestField("Job Authorized", true);
        Rec.TestField("Maintenance Request No.");
        Rec.TestField("Maintenance Request Date");
        Rec.TestField("Job Status", Rec."Job Status"::"In Progress");
        Rec."Job Status" := Rec."Job Status"::Cancelled;
        Rec."Job Cancel Date" := Today;
        Rec."Job Cancelled By" := UserId;
        Rec.Modify(true);

        //update the Equipment Status
        if Equipment.Get(Rec."Equipment No.") then begin
            if Equipment."Equipment Status" = Equipment."Equipment Status"::"At Workshop" then begin
                Equipment."Equipment Status" := Equipment."Equipment Status"::Available;
                Equipment.Modify(true);
            end else
                Error('Equipment No. %1 is not at the workshop.', Rec."Equipment No.");
        end else
            Error('Equipment No. %1 not found.', Rec."Equipment No.");

    end;

    local procedure AuthorizeJob()
    var
        UserSetup: Record "User Setup";
    begin

        if UserSetup.Get(UserId) then begin
            if not UserSetup."Can Authorize Job" then
                Error('You are not allowed to Authorize a Job, Please contact your systems Admin');
        end else begin
            Error('You are not setup, contact your systems admin');
        end;

        CheckMaintenanceRequest();
        CheckJobCardLines();
        Rec.TestField("No.");
        Rec.TestField("Posting Date");
        Rec.TestField("Equipment No.");
        Rec.TestField("Equipment Name");
        Rec.TestField("Odometer Reading (Km/Hrs)");
        Rec.TestField("Job Authorized", false);
        Rec.TestField("Maintenance Request No.");
        Rec.TestField("Maintenance Request Date");
        Rec.TestField("Job Status", Rec."Job Status"::New);
        Rec."Job Authorized" := true;
        Rec."Authorized Date" := Today;
        Rec."Authorized By" := UserId;
        Rec.Modify(true);
    end;

    //check of the Maintenance Request if it is released with a procedure
    local procedure CheckMaintenanceRequest()
    var
        MaintenanceHeader: Record "Maintenance Header";
        MaintenanceType: Enum "Maintenance Type";
    begin
        if not MaintenanceHeader.Get(MaintenanceType::"Maintenance Request", Rec."Maintenance Request No.") then
            Error('Maintenance Request No. %1 not found.', Rec."Maintenance Request No.");
        if MaintenanceHeader."Status" <> MaintenanceHeader."Status"::Released then
            Error('Maintenance Request No. %1 is not released.', Rec."Maintenance Request No.");
    end;

    //check if job card has lines
    local procedure CheckJobCardLines()
    var
        MaintenanceLine: Record "Maintenance Line";
    begin
        MaintenanceLine.Reset();
        MaintenanceLine.SetRange("Document No.", Rec."No.");
        if not MaintenanceLine.FindSet() then
            Error('No lines found for Job Card No. %1.', Rec."No.");
    end;

    local procedure WorkshopManagerSignOff()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            if UserSetup."Workshop Manager" then begin
                CheckMaintenanceRequest();
                CheckJobCardLines();
                Rec.TestField("No.");
                Rec.TestField("Posting Date");
                Rec.TestField("Equipment No.");
                Rec.TestField("Equipment Name");
                Rec.TestField("Odometer Reading (Km/Hrs)");
                Rec.TestField("Job Authorized", true);
                Rec.TestField("Maintenance Request No.");
                Rec.TestField("Maintenance Request Date");
                Rec.TestField("Report Summary");
                Rec.TestField("Other Comments");
                Rec.TestField("Workshop Manager No.");
                Rec.TestField("Mechanic");
                Rec.TestField("Signed By Workshop Manager", false);
                Rec.TestField(Remarks);
                Rec.TestField("Job Status", Rec."Job Status"::"In Progress");
                Rec.Validate("Signed By Workshop Manager", true);
                Rec.Modify();
            end else
                Error('You are not allowed to Sign off a Job, Please contact your systems Admin');
        end else begin
            Error('You are not setup, contact your systems admin');
        end;
    end;

    local procedure CreateSPRfromJob(var JobCardHeader: Record "Maintenance Header")
var
    SpareReqHeader: Record "ADT Requisition Header";
    SpareReqLine: Record "ADT Requisition Line";
    JobCardLine: Record "Maintenance Line";
    FleetManagementSetup: Record "Fleet Management Setup";
    NoSeriesMgt: Codeunit "NoSeriesManagement";
    NextNo: Code[20];
    LineNo: Integer;
    Message: Text;
begin
    JobCardHeader.TestField("Document Type", JobCardHeader."Document Type"::"Job Card");
    JobCardHeader.TestField("Job Status", JobCardHeader."Job Status"::"In Progress");
    JobCardHeader.TestField("Job Authorized",true);
     
     // Check if there is already an open Spare Parts Requisition linked to this Job Card
    SpareReqHeader.Reset();
        SpareReqHeader.SetRange("Document Type", SpareReqHeader."Document Type"::"Purchase Requisition");
        SpareReqHeader.SetRange("Request Type", SpareReqHeader."Request Type"::"Spare Parts");
        SpareReqHeader.SetRange("Job Card No.", JobCardHeader."No.");
        if SpareReqHeader.FindFirst() then
            Error('A Spare Parts Requisition (%1) is already linked to Job Card %2. Creation aborted.', SpareReqHeader."No.", JobCardHeader."No.");


    FleetManagementSetup.Get();
    // Replace this setup field with the actual spare part requisition no series field in your setup table
    NextNo := NoSeriesMgt.GetNextNo(FleetManagementSetup."Spare Part Requisition Nos", Today, true);

    SpareReqHeader.Init();
    SpareReqHeader."No." := NextNo;
    SpareReqHeader."Document Type" := SpareReqHeader."Document Type"::"Purchase Requisition";
    SpareReqHeader."Request Type" := SpareReqHeader."Request Type"::"Spare Parts";
    SpareReqHeader."No. Series" := FleetManagementSetup."Spare Part Requisition Nos";
    SpareReqHeader."Posting No. Series" := FleetManagementSetup."Spare Part Requisition Nos";
    SpareReqHeader."Posting Date" := Today;
    SpareReqHeader."Order Date" := Today;
    SpareReqHeader."Document Date" := Today;
    
    SpareReqHeader."Posting Description" := 'Spare parts request from Job Card ' + JobCardHeader."No.";
    SpareReqHeader."Equipment No." := JobCardHeader."Equipment No.";
    SpareReqHeader."Equipment Type" := JobCardHeader."Equipment Type";
    SpareReqHeader."Driver No." := JobCardHeader."Driver No.";
    SpareReqHeader."Request-By No." := JobCardHeader."Driver No.";
    SpareReqHeader."Driver Name" := JobCardHeader."Driver Name";
    SpareReqHeader."Prepared by" := JobCardHeader."Prepared by";
    SpareReqHeader."Maintenance Request No." := JobCardHeader."Maintenance Request No.";
    SpareReqHeader."Job Card No." := JobCardHeader."No.";
    SpareReqHeader.Status := SpareReqHeader.Status::Open;
    SpareReqHeader.Insert(true);

    LineNo := 1000;
    JobCardLine.Reset();
    JobCardLine.SetRange("Document Type", JobCardLine."Document Type"::"Job Card");
    JobCardLine.SetRange("Document No.", JobCardHeader."No.");
    if JobCardLine.FindSet() then
        repeat
            if JobCardLine.Type = JobCardLine.Type::Item then begin
                SpareReqLine.Init();
                SpareReqLine."Document Type" := SpareReqLine."Document Type"::"Purchase Requisition";
                SpareReqLine."Request Type" := SpareReqLine."Request Type"::"Spare Parts";
                SpareReqLine."Document No." := NextNo;
                SpareReqLine."Line No." := LineNo;
                SpareReqLine.Type := SpareReqLine.Type::Item;
                SpareReqLine.Validate("No.", JobCardLine."No.");
                SpareReqLine.Validate(Quantity, JobCardLine.Quantity);
                SpareReqLine.Description := JobCardLine.Description;
                SpareReqLine."Posting Date" := Today;
                //SpareReqLine."Equipment Type" := JobCardLine."Equipment Type";
                SpareReqLine.Insert();
                LineNo += 10000;
            end;
        until JobCardLine.Next() = 0;

    Message('Spare Part Requisition %1 created from Job Card %2', NextNo, JobCardHeader."No.");
    Message:= 'Spare Part Requisition created from Job Card. Do you want to open the requisition? ' +NextNo+'';
    if Confirm(Message, true) then begin
            
            SpareReqHeader.SetRange("Document Type", SpareReqHeader."Document Type"::"Purchase Requisition");
            SpareReqHeader.SetRange("No.", NextNo);
            Page.Run(Page::"Spare Part Requisition", SpareReqHeader);
        end;
end;


}