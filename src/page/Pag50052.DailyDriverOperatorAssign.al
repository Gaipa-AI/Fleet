page 50052 "Daily DriverOperator Assign"
{
    Caption = 'Daily Driver|Operator Assignment';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Form Header";
    SourceTableView = where("Document Type" = const("Daily Assignment"));

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                }
            }
            part(Items; "Daily Assignment Subform")
            {
                Caption = 'Items';
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
                    RunPageLink = "Document Type" = filter("Daily Assignment"),
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
            }
            group("F&unctions")
            {
                action(Report)
                {
                    Caption = 'Report';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Process;
                    //RunObject = Report "Daily DriverOperator Assignment";
                    //RunPageLink = "No." = FIELD("No.");
                }
                action(StartJourney)
                {
                    ApplicationArea = All;
                    Caption = 'Start Journey';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = SuggestChartOfAccounts;

                    trigger OnAction()
                    begin
                        //Rec.TestField(Status, Rec.Status::Released);
                        if Confirm('Are you sure you want to start', true) then
                            Rec.StartJourney();
                    end;
                }
                action(EndJourney)
                {
                    ApplicationArea = All;
                    Caption = 'End Journey';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = SuggestChartOfAccounts;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        if Confirm('Are you sure you want to End Journey?', true) then
                            Rec.EndJourney();
                    end;
                }
            }
        }
    }
}