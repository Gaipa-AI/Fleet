page 50073 "Routine Maintenance Tracker"
{
    Caption = 'Routine Maintenance Tracker';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Form Header";
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTableView = where("Document Type" = const("Routine Service Tracker"));

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
                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                    Editable = false;
                }
            }
            part(Lines; "Routine ServiceTracker Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }

        area(Factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Form Header"), "No." = FIELD("No.");
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
            group(Request)
            {
                action("Comments")
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = filter("Routine Service Tracker"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(DocAttach)
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
                action(Report)
                {
                    Caption = 'Report';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Process;
                    
                    trigger OnAction()
                    var
                        Requisition: Record "Form Line";
                    begin
                        Requisition.Reset;
                        Requisition.SetRange("Document No.", Rec."No.");
                        Requisition.SetRange("Vehicle/Equipment Location");
                        Report.Run(50014, true, false, Requisition);
                        //Report.Run(50014, true, false, Requisition);
                    end;

                }
            }
            group("F&unctions"){
                Caption= 'F&unctions';


                action(Print){
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        RequisitionHeader: Record "Form Line";
                        RoutineReport: Report "Routine Maintenance";
                    begin
                        RequisitionHeader.SETRANGE("Document Type", RequisitionHeader."Document Type"::"Routine Service Tracker");
                        RequisitionHeader.SETRANGE("Document No.", Rec."No.");
                        RoutineReport.SETTABLEVIEW(RequisitionHeader);
                        RoutineReport.RUNMODAL;
                    end;

                }
                action("Calculate Next Service Date")
                {
                    Caption = 'Calculate Next Service Date';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        RoutineServiceTrackerSubform: Page "Routine ServiceTracker Subform";
                    begin
                        //RoutineServiceTrackerSubform.CalculateNextServiceDate(Rec."No.");
                        CurrPage.UPDATE;
                    end;

                }
            }
        }
    }

    var
        myInt: Integer;
}